// api/send-email.js — Vercel Serverless Function
// Envoi de courriels via Resend pour LBMA
// Clé API dans variable d'environnement Vercel : RESEND_API_KEY

export default async function handler(req, res) {
    // CORS — autoriser seulement liguelbma.org
    res.setHeader('Access-Control-Allow-Origin', 'https://www.liguelbma.org');
    res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

    if (req.method === 'OPTIONS') {
        return res.status(200).end();
    }

    if (req.method !== 'POST') {
        return res.status(405).json({ error: 'Méthode non autorisée' });
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
