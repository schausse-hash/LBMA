const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_SERVICE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;
const RESEND_API_KEY = process.env.RESEND_API_KEY;

async function sbFetch(path, options = {}) {
    const res = await fetch(`${SUPABASE_URL}/rest/v1/${path}`, {
        headers: {
            apikey: SUPABASE_SERVICE_KEY,
            Authorization: `Bearer ${SUPABASE_SERVICE_KEY}`,
            'Content-Type': 'application/json',
            Prefer: 'return=representation',
            ...options.headers,
        },
        ...options,
    });
    if (!res.ok) throw new Error(`Supabase ${res.status}: ${await res.text()}`);
    return res.json();
}

export default async function handler(req, res) {
    res.setHeader('Access-Control-Allow-Origin', 'https://www.liguelbma.org');
    res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
    if (req.method === 'OPTIONS') return res.status(200).end();
    if (req.method !== 'POST') return res.status(405).json({ error: 'Method not allowed' });

    const { joueur_id } = req.body;
    if (!joueur_id) return res.status(400).json({ error: 'joueur_id requis' });

    try {
        // 1. Charger le joueur
        const joueurs = await sbFetch(`joueurs_liste?id=eq.${joueur_id}`);
        if (!joueurs.length) return res.status(404).json({ error: 'Joueur introuvable' });
        const joueur = joueurs[0];
        if (!joueur.courriel) return res.status(400).json({ error: 'Pas de courriel' });

        // 2. Créer le token
        const [tokenRow] = await sbFetch('fiche_tokens', {
            method: 'POST',
            body: JSON.stringify({ joueur_id: joueur.id }),
        });

        const lien = `https://liguelbma.org/fiche-joueur.html?token=${tokenRow.token}`;
        const nom = joueur.nom || '';

        // 3. Envoyer via Resend (fetch direct, sans package)
        const response = await fetch('https://api.resend.com/emails', {
            method: 'POST',
            headers: {
                'Authorization': 'Bearer ' + RESEND_API_KEY,
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                from: 'LBMA <noreply@liguelbma.org>',
                reply_to: 'michelpla@videotron.ca',
                to: [joueur.courriel],
                subject: 'LBMA 2026 — Veuillez vérifier votre fiche de joueur',
                html: `
                    <div style="font-family:Arial,sans-serif;max-width:600px;margin:0 auto;color:#333">
                        <div style="background:#1E3A5F;padding:2rem;text-align:center">
                            <div style="font-size:2.5rem;font-weight:900;color:white;letter-spacing:.15em;font-family:Georgia,serif">LBMA</div>
                            <div style="color:#D4AF37;font-size:.9rem;letter-spacing:.1em;margin-top:.25rem">LIGUE DE BALLE MOLLE AMICALE · DEPUIS 1976</div>
                        </div>
                        <div style="padding:2rem">
                            <p style="margin-bottom:1.5rem">Bonjour <strong>${nom}</strong>,</p>
                            <p style="line-height:1.7;margin-bottom:1rem">Avant la saison 2026, nous vous demandons de vérifier et compléter votre fiche de joueur.</p>
                            <p style="line-height:1.7;margin-bottom:2rem">Cliquez sur le bouton ci-dessous pour accéder à votre fiche personnelle. Vous pourrez y corriger vos coordonnées et ajouter toute information manquante.</p>
                            <div style="text-align:center;margin:2rem 0">
                                <a href="${lien}" style="background:#1E3A5F;color:white;padding:14px 32px;text-decoration:none;border-radius:6px;font-size:16px;display:inline-block">
                                    Accéder à ma fiche →
                                </a>
                            </div>
                            <p style="font-size:13px;color:#888">Ce lien est valide pendant 7 jours et ne peut être utilisé qu'une seule fois.</p>
                        </div>
                        <div style="height:4px;background:linear-gradient(90deg,#1E3A5F,#D4AF37,#CC0000)"></div>
                        <div style="background:#f5f1e8;padding:1.5rem;text-align:center;font-size:.8rem;color:#888">
                            Ligue de Balle Molle Amicale (LBMA) · <a href="https://www.liguelbma.org" style="color:#1E3A5F">liguelbma.org</a>
                        </div>
                    </div>
                `
            })
        });

        const data = await response.json();
        if (!response.ok) return res.status(response.status).json({ error: data.message || 'Erreur Resend' });

        return res.status(200).json({ succes: true });

    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
}
