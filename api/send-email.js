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
