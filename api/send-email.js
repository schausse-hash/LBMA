// api/send-email.js — Vercel Serverless Function
// Envoi de courriels via Resend pour LBMA
// Clé API dans variable d'environnement Vercel : RESEND_API_KEY

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

// Aperçu Vercel (branche / PR) : on SIMULE l'envoi, rien ne part chez Resend.
// Les aperçus utilisent les mêmes clés et la même base que la production.
const SIMULATION = process.env.VERCEL_ENV === 'preview' || process.env.VERCEL_ENV === 'development';

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

// Limite quotidienne LBMA (déc. 2026 : Resend gratuit = 100/jour PARTAGÉS avec
// FaceHub et dentiste.com). LBMA se garde 70/jour (paramètre lbma_courriels_jour,
// modifiable dans Coûts du site). Compte masse + fiches + anniversaires + réponses
// SMS transférées d'aujourd'hui (heure de Montréal), via lbma_courriels_aujourdhui().
// En aperçu, on compte les envois SIMULÉS : on peut tester l'arrêt sans rien envoyer.
// En cas de panne du compteur, on laisse passer (Resend refusera au-delà de 100).
async function quotaDuJour(simulation) {
    const url = process.env.SUPABASE_URL, cle = process.env.SUPABASE_SERVICE_ROLE_KEY;
    const h = { apikey: cle, Authorization: 'Bearer ' + cle, 'Content-Type': 'application/json' };
    try {
        const [r1, r2] = await Promise.all([
            fetch(url + '/rest/v1/rpc/lbma_courriels_aujourdhui', { method: 'POST', headers: h, body: JSON.stringify({ p_simulation: !!simulation }) }),
            fetch(url + '/rest/v1/couts_parametres?cle=eq.lbma_courriels_jour&select=valeur', { headers: h })
        ]);
        if (!r1.ok) return null;
        const envoyes = Number(await r1.json());
        const p = r2.ok ? await r2.json() : [];
        const limite = Math.round(Number(p[0] && p[0].valeur)) || 70;
        if (!Number.isFinite(envoyes)) return null;
        return { envoyes, limite, atteinte: envoyes >= limite };
    } catch (e) {
        console.error('quotaDuJour :', e.message);
        return null;
    }
}

function reponseLimite(res, q) {
    return res.status(429).json({
        error: 'Limite LBMA de ' + q.limite + ' courriels par jour atteinte (' + q.envoyes + ' envoyés aujourd\'hui). La suite partira demain avec « Reprendre ».',
        limite_jour: true, envoyes: q.envoyes, limite: q.limite
    });
}

// Resend refuse aussi au-delà de son propre quota (100/jour en gratuit) : même traitement.
function quotaResendDepasse(status, data) {
    return status === 429 && /quota/i.test(String((data && data.name) || ''));
}

export default async function handler(req, res) {
    // CORS — autoriser seulement liguelbma.org
    res.setHeader('Access-Control-Allow-Origin', 'https://www.liguelbma.org');
    res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, x-lbma-token');

    if (req.method === 'OPTIONS') {
        return res.status(200).end();
    }

    if (req.method !== 'POST') {
        return res.status(405).json({ error: 'Méthode non autorisée' });
    }

    const admin = await verifierSession(req, ['admin', 'superadmin']);
    if (!admin) {
        return res.status(401).json({ error: 'Non autorisé — reconnecte-toi à l\'administration.' });
    }

    const RESEND_API_KEY = process.env.RESEND_API_KEY;
    if (!RESEND_API_KEY) {
        return res.status(500).json({ error: 'Clé Resend manquante (variable d\'environnement RESEND_API_KEY)' });
    }

    const { to, subject, html } = req.body;

    if (!to || !subject || !html) {
        return res.status(400).json({ error: 'Champs manquants : to, subject, html requis' });
    }

    if (!to.includes('@') || to.length > 254) {
        return res.status(400).json({ error: 'Adresse courriel invalide : ' + to });
    }

    const quota = await quotaDuJour(SIMULATION);
    if (quota && quota.atteinte) return reponseLimite(res, quota);

    if (SIMULATION) {
        await journaliser({ canal: 'courriel', type_envoi: 'courriel_masse', nb_destinataires: 1, nb_reussis: 1, nb_echecs: 0,
            cout_estime_usd: 0, simulation: true, demande_par: admin.username, sujet: String(subject).slice(0, 160) });
        return res.status(200).json({ success: true, simulation: true, id: 'simulation' });
    }

    try {
        const response = await fetch('https://api.resend.com/emails', {
            method: 'POST',
            headers: {
                'Authorization': 'Bearer ' + RESEND_API_KEY,
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                from: 'LBMA <noreply@liguelbma.org>',
                reply_to: 'michelpla@videotron.ca',
                to: [to],
                subject: subject,
                html: html
            })
        });

        const data = await response.json();

        await journaliser({ canal: 'courriel', type_envoi: 'courriel_masse', nb_destinataires: 1,
            nb_reussis: response.ok ? 1 : 0, nb_echecs: response.ok ? 0 : 1,
            cout_estime_usd: 0, simulation: false, demande_par: admin.username, sujet: String(subject).slice(0, 160) });

        if (quotaResendDepasse(response.status, data)) {
            return res.status(429).json({ error: 'Resend refuse : quota du jour atteint (tous les sites ensemble). La suite partira demain avec « Reprendre ».', limite_jour: true });
        }
        if (!response.ok) {
            console.error('Erreur Resend:', data);
            return res.status(response.status).json({ error: data.message || 'Erreur Resend', details: data });
        }

        return res.status(200).json({ success: true, id: data.id });

    } catch (err) {
        console.error('Erreur serveur:', err);
        return res.status(500).json({ error: 'Erreur serveur : ' + err.message });
    }
}
