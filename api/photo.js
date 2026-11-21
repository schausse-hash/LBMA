// api/photo.js — Vercel Serverless Function
// Téléversement des photos (joueurs, équipes, Temple, Direction) — sécurité phase D (nov. 2026).
//
// Avant : n'importe qui avec la clé publique pouvait ajouter, remplacer ou supprimer des
// fichiers dans Supabase Storage. Maintenant les buckets n'acceptent plus d'écriture
// anonyme : un admin connecté demande ici une URL de dépôt signée (valide 2 heures,
// pour UN fichier précis), puis le navigateur y envoie la photo directement.
// La signature est faite avec la clé service_role, qui ne quitte jamais le serveur.

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

// Chemins permis, par bucket. Rien d'autre ne peut être signé.
const CHEMINS = {
    'joueurs-photos': [
        /^equipes\/[A-Z]{3,12}_\d{4}\.jpg$/,                       // photo d'équipe (remplacée chaque fois)
        /^[a-z0-9_]{1,80}_\d{10,14}\.(jpg|jpeg|png|webp|gif)$/     // photo de joueur (nom + horodatage)
    ],
    'temple': [
        /^(batisseur|trophee|membre|contact)_[0-9]{1,14}\.(jpg|jpeg|png|webp|gif)$/
    ]
};
const TYPES = ['image/jpeg', 'image/png', 'image/webp', 'image/gif'];

export default async function handler(req, res) {
    res.setHeader('Access-Control-Allow-Origin', 'https://www.liguelbma.org');
    res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, x-lbma-token');
    res.setHeader('Cache-Control', 'no-store');
    if (req.method === 'OPTIONS') return res.status(200).end();
    if (req.method !== 'POST') return res.status(405).json({ error: 'Méthode non autorisée' });

    const admin = await verifierSession(req, ['admin', 'superadmin']);
    if (!admin) return res.status(401).json({ error: 'Non autorisé — reconnecte-toi à l\'administration.' });

    const { bucket, chemin, type } = req.body || {};
    const regles = CHEMINS[bucket];
    if (!regles) return res.status(400).json({ error: 'Dossier de photos inconnu' });
    if (typeof chemin !== 'string' || !regles.some(r => r.test(chemin))) {
        return res.status(400).json({ error: 'Nom de fichier refusé : ' + String(chemin).slice(0, 80) });
    }
    if (!TYPES.includes(type)) return res.status(400).json({ error: 'Seules les images JPEG, PNG, WebP ou GIF sont acceptées' });

    const url = process.env.SUPABASE_URL, cle = process.env.SUPABASE_SERVICE_ROLE_KEY;
    if (!url || !cle) return res.status(500).json({ error: 'Variables Supabase manquantes dans Vercel' });

    try {
        const r = await fetch(url + '/storage/v1/object/upload/sign/' + bucket + '/' + chemin, {
            method: 'POST',
            headers: { apikey: cle, Authorization: 'Bearer ' + cle, 'x-upsert': 'true' }
        });
        const data = await r.json().catch(() => ({}));
        if (!r.ok || !data.url) {
            console.error('Signature refusée :', r.status, data);
            return res.status(502).json({ error: 'Supabase refuse de préparer le dépôt (' + r.status + ')' });
        }
        return res.status(200).json({
            depot: url + '/storage/v1' + data.url,
            publique: url + '/storage/v1/object/public/' + bucket + '/' + chemin
        });
    } catch (e) {
        console.error('api/photo :', e);
        return res.status(500).json({ error: 'Erreur serveur : ' + e.message });
    }
}
