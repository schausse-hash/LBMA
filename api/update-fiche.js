const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_SERVICE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;

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
  if (!res.ok) {
    const err = await res.text();
    throw new Error(`Supabase error: ${res.status} — ${err}`);
  }
  return res.json();
}

// Champs autorisés à être mis à jour par le joueur
const CHAMPS_AUTORISES = [
  'courriel', 'telephone1', 'telephone2', 'naissance',
  'adresse', 'ville', 'province', 'code_postal'
];

export default async function handler(req, res) {
  if (req.method !== 'POST') return res.status(405).json({ error: 'Method not allowed' });

  const { token, donnees } = req.body;

  if (!token || !donnees) {
    return res.status(400).json({ error: 'Token et données requis.' });
  }

  try {
    // 1. Vérifier que le token existe, est valide et non expiré
    const tokens = await sbFetch(
      `fiche_tokens?token=eq.${token}&used=eq.false&select=id,joueur_id,expires_at`
    );

    if (!tokens.length) {
      return res.status(403).json({ error: 'Lien invalide ou déjà utilisé.' });
    }

    const tokenRow = tokens[0];

    if (new Date(tokenRow.expires_at) < new Date()) {
      return res.status(403).json({ error: 'Ce lien a expiré. Contactez l\'administrateur.' });
    }

    // 2. Filtrer seulement les champs autorisés
    const update = {};
    for (const champ of CHAMPS_AUTORISES) {
      if (donnees[champ] !== undefined) {
        update[champ] = donnees[champ];
      }
    }

    if (Object.keys(update).length === 0) {
      return res.status(400).json({ error: 'Aucune donnée valide à mettre à jour.' });
    }

    // 3. Mettre à jour joueurs_liste
    await sbFetch(`joueurs_liste?id=eq.${tokenRow.joueur_id}`, {
      method: 'PATCH',
      body: JSON.stringify(update),
    });

    // 4. Marquer le token comme utilisé
    await sbFetch(`fiche_tokens?id=eq.${tokenRow.id}`, {
      method: 'PATCH',
      body: JSON.stringify({ used: true }),
    });

    return res.status(200).json({ succes: true });

  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
}
