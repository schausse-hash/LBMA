// api/send-sms.js — VERSION PRODUCTION
// Securite (sept. 2026) : seul un admin connecte peut declencher un envoi.
// Le jeton de session (emis par login_user) arrive dans l'en-tete x-lbma-token
// et est valide dans Supabase avec la cle service_role.
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

// Aperçu Vercel (branche / PR) : on SIMULE l'envoi, rien ne part chez Twilio.
// Les aperçus utilisent les mêmes clés et la même base que la production :
// sans ce garde-fou, tester une PR enverrait de vrais SMS à tous les joueurs.
const SIMULATION = process.env.VERCEL_ENV === 'preview' || process.env.VERCEL_ENV === 'development';

// Segments SMS : 160 caractères GSM-7 (153 par segment si plusieurs), mais
// 70 seulement (67) dès qu'un caractère hors GSM-7 apparaît (ê, ç, ô, emoji…).
const GSM7 = '@£$¥èéùìòÇ\nØø\rÅåΔ_ΦΓΛΩΠΨΣΘΞÆæßÉ !"#¤%&\'()*+,-./0123456789:;<=>?¡ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÑÜ§¿abcdefghijklmnopqrstuvwxyzäöñüà';
const GSM7_EXT = '^{}\\[~]|€\f';
function segmentsSMS(txt) {
    let unites = 0;
    for (const c of txt) {
        if (GSM7.includes(c)) unites += 1;
        else if (GSM7_EXT.includes(c)) unites += 2;
        else {
            let n = 0;
            for (const d of txt) n += d.codePointAt(0) > 0xFFFF ? 2 : 1;
            return n <= 70 ? 1 : Math.ceil(n / 67);
        }
    }
    return unites <= 160 ? 1 : Math.ceil(unites / 153);
}

// Journal des envois (page Coûts du site). Ne bloque jamais l'envoi.
async function journaliser(ligne) {
    try {
        await fetch(process.env.SUPABASE_URL + '/rest/v1/journal_envois', {
            method: 'POST',
            headers: {
                apikey: process.env.SUPABASE_SERVICE_ROLE_KEY,
                Authorization: 'Bearer ' + process.env.SUPABASE_SERVICE_ROLE_KEY,
                'Content-Type': 'application/json',
                Prefer: 'return=minimal'
            },
            body: JSON.stringify(ligne)
        });
    } catch (e) { console.error('journal_envois :', e.message); }
}

export default async function handler(req, res) {
    if (req.method !== 'POST') return res.status(405).json({ error: 'Method not allowed' });

    const admin = await verifierSession(req, ['admin', 'superadmin']);
    if (!admin) return res.status(401).json({ error: 'Non autorisé — reconnecte-toi à l\'administration.' });
    console.log('Envoi SMS demandé par', admin.username);

    const { message } = req.body;
    if (!message || !message.trim()) return res.status(400).json({ error: 'Message requis' });

    const PREFIX = 'Un message de l exécutif de la LBMA:\n';
    const messageComplet = PREFIX + message.trim();

    const SB_URL = process.env.SUPABASE_URL;
    const SB_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;
    const SID    = process.env.TWILIO_ACCOUNT_SID;
    const TOKEN  = process.env.TWILIO_AUTH_TOKEN;
    const FROM   = process.env.TWILIO_FROM;

    // Vérification détaillée des variables manquantes
    const manquantes = [];
    if (!SB_URL)  manquantes.push('SUPABASE_URL');
    if (!SB_KEY)  manquantes.push('SUPABASE_SERVICE_ROLE_KEY');
    if (!SID)     manquantes.push('TWILIO_ACCOUNT_SID');
    if (!TOKEN)   manquantes.push('TWILIO_AUTH_TOKEN');
    if (!FROM)    manquantes.push('TWILIO_FROM');
    if (manquantes.length > 0) {
        console.error('Variables manquantes:', manquantes.join(', '));
        return res.status(500).json({ error: 'Variables manquantes: ' + manquantes.join(', ') });
    }

    // Charger les joueurs de la saison ACTIVE (saison_info), pas de l'année du calendrier :
    // entre le 1er janvier et la bascule de février, l'année du calendrier ne trouvait aucun joueur.
    let saison = String(new Date().getFullYear());
    try {
        const si = await fetch(`${SB_URL}/rest/v1/saison_info?cle=eq.saison_active&select=valeur&limit=1`, {
            headers: { apikey: SB_KEY, Authorization: 'Bearer ' + SB_KEY }
        });
        const rows = si.ok ? await si.json() : [];
        if (rows[0] && /^\d{4}$/.test(String(rows[0].valeur).trim())) saison = String(rows[0].valeur).trim();
    } catch (e) { console.error('saison_active illisible, année du calendrier utilisée :', e.message); }
    const sbUrl = `${SB_URL}/rest/v1/joueurs_liste?saison=eq.${saison}&or=(actif.eq.true,actif.is.null)&telephone1=not.is.null&select=nom,telephone1`;
    console.log('Supabase URL:', sbUrl);

    const sbRes = await fetch(sbUrl, {
        headers: {
            'apikey': SB_KEY,
            'Authorization': 'Bearer ' + SB_KEY,
            'Range': '0-9999'
        }
    });

    if (!sbRes.ok) {
        const errText = await sbRes.text();
        console.error('Supabase erreur:', sbRes.status, errText);
        return res.status(500).json({ error: 'Erreur chargement joueurs: ' + sbRes.status + ' — ' + errText });
    }

    const joueurs = await sbRes.json();
    console.log('Joueurs trouvés:', joueurs.length);

    // Normaliser les numéros (format E.164 canadien)
    function normaliserTel(tel) {
        if (!tel) return null;
        var digits = tel.replace(/\D/g, '');
        if (digits.length === 10) return '+1' + digits;
        if (digits.length === 11 && digits[0] === '1') return '+' + digits;
        return null;
    }

    const valides = joueurs
        .map(j => ({ ...j, tel: normaliserTel(j.telephone1) }))
        .filter(j => j.tel !== null);

    console.log('Numéros valides:', valides.length);

    if (!valides.length) return res.status(200).json({ succes: true, envoyes: 0, erreurs: 0, message: 'Aucun numéro valide trouvé' });

    const credentials = Buffer.from(`${SID}:${TOKEN}`).toString('base64');
    const url = `https://api.twilio.com/2010-04-01/Accounts/${SID}/Messages.json`;

    let envoyes = 0, erreurs = 0, details = [], segments = 0;
    const segParMessage = segmentsSMS(messageComplet);

    for (const j of valides) {
        const nomAff = j.nom || 'Joueur';
        if (SIMULATION) {
            envoyes++;
            segments += segParMessage;
            details.push({ nom: nomAff, tel: j.tel, statut: 'ok', raison: 'simulation — non envoyé' });
            continue;
        }
        try {
            const r = await fetch(url, {
                method: 'POST',
                headers: {
                    'Authorization': 'Basic ' + credentials,
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams({
                    From: FROM,
                    To:   j.tel,
                    Body: messageComplet
                }).toString()
            });
            const data = await r.json();
            if (r.ok && data.sid) {
                envoyes++;
                segments += parseInt(data.num_segments, 10) || segParMessage;
                details.push({ nom: nomAff, tel: j.tel, statut: 'ok' });
            } else {
                erreurs++;
                console.error('Twilio erreur pour', nomAff, ':', data.message);
                details.push({ nom: nomAff, tel: j.tel, statut: 'erreur', raison: data.message || 'Inconnu' });
            }
        } catch (e) {
            erreurs++;
            details.push({ nom: nomAff, tel: j.tel, statut: 'erreur', raison: e.message });
        }
        await new Promise(r => setTimeout(r, 100));
    }

    const prixSegment = 0.0079; // Twilio Canada, sans frais des transporteurs — le montant réel est lu dans Twilio
    await journaliser({
        canal: 'sms', type_envoi: 'sms_alerte',
        nb_destinataires: valides.length, nb_reussis: envoyes, nb_echecs: erreurs,
        segments, cout_estime_usd: +(segments * prixSegment + erreurs * 0.001).toFixed(4),
        simulation: SIMULATION, demande_par: admin.username,
        sujet: message.trim().slice(0, 160)
    });

    return res.status(200).json({ succes: true, simulation: SIMULATION, envoyes, erreurs, total: valides.length, segments, segments_par_message: segParMessage, details });
}
