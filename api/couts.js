// api/couts.js — Données de la page Super Admin « 💰 Coûts du site »
//
// GET  : tout ce qu'il faut pour afficher la page (coûts fixes, journal des
//        envois, utilisation réelle Twilio, taux USD→CAD de la Banque du Canada…)
// POST : modifier un coût fixe ou un paramètre de calcul
//
// Réservé au superadmin. Les tables couts_* et journal_envois sont en RLS sans
// policy : seule la clé service_role (ici, côté serveur) peut y toucher.

async function verifierSession(req, rolesPermis) {
    const token = req.headers['x-lbma-token'];
    if (!token || typeof token !== 'string' || !/^[0-9a-f]{64}$/.test(token)) return null;
    const url = process.env.SUPABASE_URL, cle = process.env.SUPABASE_SERVICE_ROLE_KEY;
    if (!url || !cle) return null;
    try {
        const r = await fetch(url + '/rest/v1/rpc/admin_session_info', {
            method: 'POST',
            headers: { apikey: cle, Authorization: 'Bearer ' + cle, 'Content-Type': 'application/json' },
            body: JSON.stringify({ p_token: token })
        });
        if (!r.ok) return null;
        const rows = await r.json();
        const u = Array.isArray(rows) ? rows[0] : null;
        return u && rolesPermis.includes(u.role) ? u : null;
    } catch (e) { return null; }
}

function sb(path, options = {}) {
    const cle = process.env.SUPABASE_SERVICE_ROLE_KEY;
    return fetch(process.env.SUPABASE_URL + '/rest/v1/' + path, {
        ...options,
        headers: {
            apikey: cle,
            Authorization: 'Bearer ' + cle,
            'Content-Type': 'application/json',
            ...(options.headers || {})
        }
    });
}

async function sbJson(path, options) {
    const r = await sb(path, options);
    if (!r.ok) throw new Error('Supabase ' + r.status + ' : ' + (await r.text()));
    return r.json();
}

// Nombre de lignes sans les télécharger (en-tête Content-Range)
async function sbCompter(path) {
    const r = await sb(path, { method: 'HEAD', headers: { Prefer: 'count=exact', Range: '0-0' } });
    const cr = r.headers.get('content-range') || '';
    const n = parseInt(cr.split('/')[1], 10);
    return Number.isFinite(n) ? n : null;
}

async function avecDelai(promesse, ms) {
    let minuterie;
    const delai = new Promise((_, rej) => { minuterie = setTimeout(() => rej(new Error('Délai dépassé')), ms); });
    try { return await Promise.race([promesse, delai]); } finally { clearTimeout(minuterie); }
}

// Taux de change officiel de la Banque du Canada (dernier jour ouvrable)
async function tauxBanqueDuCanada() {
    const r = await avecDelai(fetch('https://www.bankofcanada.ca/valet/observations/FXUSDCAD/json?recent=1'), 4000);
    if (!r.ok) throw new Error('Banque du Canada ' + r.status);
    const d = await r.json();
    const obs = d.observations && d.observations[0];
    const v = obs && obs.FXUSDCAD && parseFloat(obs.FXUSDCAD.v);
    if (!v) throw new Error('Taux introuvable');
    return { valeur: v, date: obs.d, source: 'Banque du Canada' };
}

// Utilisation réelle facturée par Twilio, par mois (12 derniers mois)
async function utilisationTwilio() {
    const SID = process.env.TWILIO_ACCOUNT_SID, TOKEN = process.env.TWILIO_AUTH_TOKEN;
    if (!SID || !TOKEN) return { ok: false, erreur: 'Clés Twilio absentes dans Vercel' };
    const auth = 'Basic ' + Buffer.from(SID + ':' + TOKEN).toString('base64');
    const base = 'https://api.twilio.com/2010-04-01/Accounts/' + SID;

    const debut = new Date();
    debut.setUTCDate(1);
    debut.setUTCMonth(debut.getUTCMonth() - 11);
    const du = debut.toISOString().slice(0, 10);
    const au = new Date().toISOString().slice(0, 10);

    async function categorie(cat) {
        const url = base + '/Usage/Records/Monthly.json?Category=' + cat + '&StartDate=' + du + '&EndDate=' + au + '&PageSize=50';
        const r = await avecDelai(fetch(url, { headers: { Authorization: auth } }), 6000);
        if (!r.ok) throw new Error('Twilio ' + r.status + ' (' + cat + ')');
        const d = await r.json();
        return d.usage_records || [];
    }

    const [sms, numeros, total, solde] = await Promise.all([
        categorie('sms'),
        categorie('phonenumbers'),
        categorie('totalprice'),
        avecDelai(fetch(base + '/Balance.json', { headers: { Authorization: auth } }), 6000)
            .then(r => (r.ok ? r.json() : null)).catch(() => null)
    ]);

    const mois = {};
    function ligne(cle) {
        if (!mois[cle]) mois[cle] = { mois: cle, sms_messages: 0, sms_segments: 0, sms_usd: 0, numeros_usd: 0, total_usd: 0 };
        return mois[cle];
    }
    sms.forEach(u => {
        const l = ligne(String(u.start_date).slice(0, 7));
        l.sms_messages += parseFloat(u.count) || 0;
        l.sms_segments += parseFloat(u.usage) || 0;
        l.sms_usd += Math.abs(parseFloat(u.price) || 0);
    });
    numeros.forEach(u => { ligne(String(u.start_date).slice(0, 7)).numeros_usd += Math.abs(parseFloat(u.price) || 0); });
    total.forEach(u => { ligne(String(u.start_date).slice(0, 7)).total_usd += Math.abs(parseFloat(u.price) || 0); });

    return {
        ok: true,
        devise: (total[0] && total[0].price_unit) || 'usd',
        mois: Object.values(mois).sort((a, b) => a.mois.localeCompare(b.mois)),
        solde: solde ? { montant: parseFloat(solde.balance), devise: solde.currency } : null
    };
}

async function lire(res) {
    const depuis = new Date(Date.now() - 400 * 864e5).toISOString();
    const depuisDate = depuis.slice(0, 10);

    // Saison active (clé saison_active dans saison_info)
    let saison = String(new Date().getFullYear());
    try {
        const s = await sbJson('saison_info?cle=eq.saison_active&select=valeur');
        if (s[0] && s[0].valeur) saison = String(s[0].valeur);
    } catch (e) { /* on garde l'année courante */ }

    const [fixes, parametres, journal, anniversaires, tailleBd, nbTel, nbCourriel, twilio, taux, smsEnAttente] = await Promise.all([
        sbJson('couts_fixes?order=ordre.asc,id.asc'),
        sbJson('couts_parametres?select=cle,valeur,description'),
        sbJson('journal_envois?created_at=gte.' + encodeURIComponent(depuis) + '&order=created_at.desc&limit=5000'),
        sbJson('birthday_emails_sent?sent_date=gte.' + depuisDate + '&select=sent_date&limit=5000'),
        sbJson('rpc/lbma_taille_bd', { method: 'POST', body: '{}' }).catch(() => null),
        sbCompter('joueurs_liste?saison=eq.' + saison + '&or=(actif.eq.true,actif.is.null)&telephone1=not.is.null&select=id').catch(() => null),
        sbCompter('joueurs_liste?saison=eq.' + saison + '&or=(actif.eq.true,actif.is.null)&courriel=not.is.null&courriel=neq.&select=id').catch(() => null),
        utilisationTwilio().catch(e => ({ ok: false, erreur: e.message })),
        tauxBanqueDuCanada().catch(e => ({ erreur: e.message })),
        sbJson('sms_recus?transfere=eq.false&order=recu_le.desc&limit=20&select=recu_le,de,nom_joueur,texte,erreur,tentatives').catch(() => [])
    ]);

    const params = {};
    parametres.forEach(p => { params[p.cle] = { valeur: parseFloat(p.valeur), description: p.description }; });
    if (!taux.valeur) {
        taux.valeur = (params.taux_usd_cad && params.taux_usd_cad.valeur) || 1.4;
        taux.source = 'Paramètre de secours';
    }

    return res.status(200).json({
        genere_le: new Date().toISOString(),
        environnement: process.env.VERCEL_ENV || 'inconnu',
        // Même règle que send-sms / send-email / send-fiche
        envois_simules: process.env.VERCEL_ENV === 'preview' || process.env.VERCEL_ENV === 'development',
        saison,
        taux,
        parametres: params,
        fixes,
        journal,
        anniversaires: anniversaires.map(a => a.sent_date),
        base_de_donnees: { octets: typeof tailleBd === 'number' ? tailleBd : null, inclus_octets: 8 * 1024 ** 3 },
        joueurs: { avec_telephone: nbTel, avec_courriel: nbCourriel },
        twilio,
        sms_non_transferes: smsEnAttente
    });
}

function nombre(v, min, max) {
    const n = parseFloat(v);
    if (!Number.isFinite(n) || n < min || n > max) return null;
    return n;
}

async function ecrire(req, res) {
    const b = req.body || {};

    if (b.action === 'fixe_enregistrer') {
        const ligne = {
            service: String(b.service || '').trim().slice(0, 80),
            description: String(b.description || '').trim().slice(0, 500),
            categorie: String(b.categorie || 'hebergement').trim().slice(0, 40),
            montant: nombre(b.montant, 0, 100000),
            devise: b.devise === 'CAD' ? 'CAD' : 'USD',
            frequence: b.frequence === 'an' ? 'an' : 'mois',
            part_lbma: nombre(b.part_lbma, 0, 1),
            a_confirmer: !!b.a_confirmer,
            actif: b.actif !== false,
            maj_le: new Date().toISOString()
        };
        if (!ligne.service) return res.status(400).json({ error: 'Le nom du service est requis' });
        if (ligne.montant === null) return res.status(400).json({ error: 'Montant invalide' });
        if (ligne.part_lbma === null) return res.status(400).json({ error: 'La part LBMA doit être entre 0 et 100 %' });

        if (b.id) {
            if (!/^[0-9]+$/.test(String(b.id))) return res.status(400).json({ error: 'id invalide' });
            await sbJson('couts_fixes?id=eq.' + b.id, { method: 'PATCH', headers: { Prefer: 'return=representation' }, body: JSON.stringify(ligne) });
        } else {
            ligne.ordre = nombre(b.ordre, 0, 10000) || 100;
            await sbJson('couts_fixes', { method: 'POST', headers: { Prefer: 'return=representation' }, body: JSON.stringify(ligne) });
        }
        return res.status(200).json({ succes: true });
    }

    if (b.action === 'fixe_supprimer') {
        if (!/^[0-9]+$/.test(String(b.id || ''))) return res.status(400).json({ error: 'id invalide' });
        const r = await sb('couts_fixes?id=eq.' + b.id, { method: 'DELETE' });
        if (!r.ok) return res.status(500).json({ error: 'Suppression impossible' });
        return res.status(200).json({ succes: true });
    }

    if (b.action === 'parametre_enregistrer') {
        const permis = ['taux_usd_cad', 'sms_prix_segment_usd', 'resend_quota_jour', 'resend_quota_mois'];
        if (!permis.includes(b.cle)) return res.status(400).json({ error: 'Paramètre inconnu' });
        const v = nombre(b.valeur, 0, 1000000);
        if (v === null) return res.status(400).json({ error: 'Valeur invalide' });
        await sbJson('couts_parametres?cle=eq.' + b.cle, { method: 'PATCH', headers: { Prefer: 'return=representation' }, body: JSON.stringify({ valeur: v }) });
        return res.status(200).json({ succes: true });
    }

    return res.status(400).json({ error: 'Action inconnue' });
}

export default async function handler(req, res) {
    res.setHeader('Cache-Control', 'no-store');
    if (req.method !== 'GET' && req.method !== 'POST') return res.status(405).json({ error: 'Méthode non autorisée' });

    const admin = await verifierSession(req, ['superadmin']);
    if (!admin) return res.status(401).json({ error: 'Réservé au Super Admin — reconnecte-toi à l\'administration.' });

    if (!process.env.SUPABASE_URL || !process.env.SUPABASE_SERVICE_ROLE_KEY) {
        return res.status(500).json({ error: 'Variables Supabase manquantes dans Vercel' });
    }

    try {
        return req.method === 'GET' ? await lire(res) : await ecrire(req, res);
    } catch (e) {
        console.error('api/couts :', e);
        return res.status(500).json({ error: e.message });
    }
}
