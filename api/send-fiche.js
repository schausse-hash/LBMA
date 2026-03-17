import { Resend } from 'resend';

const resend = new Resend(process.env.RESEND_API_KEY);
const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_SERVICE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;

const DELAY_MS = 300;
const sleep = (ms) => new Promise(r => setTimeout(r, ms));

// Roles exclus de l'envoi
const ROLES_EXCLUS = ['coach', 'admin', 'superadmin', 'marqueur'];

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

export default async function handler(req, res) {
  if (req.method !== 'POST') return res.status(405).json({ error: 'Method not allowed' });

  const saison = new Date().getFullYear();

  // 1. Charger les joueurs actifs de la saison (excluant les rôles admin/coach)
  let joueurs;
  try {
    joueurs = await sbFetch(
      `joueurs_liste?saison=eq.${saison}&order=nom.asc`,
      { headers: { Range: '0-9999' } }
    );
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }

  // Filtrer les rôles exclus
  const joueursFiltres = joueurs.filter(j => {
    const role = (j.role || '').toLowerCase();
    return !ROLES_EXCLUS.includes(role);
  });

  if (joueursFiltres.length === 0) {
    return res.status(200).json({ message: 'Aucun joueur à contacter.', envoyes: 0 });
  }

  const resultats = [];

  for (const joueur of joueursFiltres) {
    try {
      // 2. Créer un token unique dans fiche_tokens
      const [tokenRow] = await sbFetch('fiche_tokens', {
        method: 'POST',
        body: JSON.stringify({
          joueur_id: joueur.id,
        }),
      });

      const lien = `https://liguelbma.org/fiche-joueur.html?token=${tokenRow.token}`;

      // 3. Envoyer le courriel
      const prenom = joueur.prenom || '';
      const nom = joueur.nom || '';
      const courriel = joueur.courriel;

      if (!courriel) {
        resultats.push({ joueur: `${prenom} ${nom}`, statut: 'ignoré — pas de courriel' });
        continue;
      }

      await resend.emails.send({
        from: 'LBMA <info@liguelbma.org>',
        to: courriel,
        subject: 'LBMA 2026 — Veuillez vérifier votre fiche de joueur',
        html: `
          <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; color: #333;">
            <div style="background: #1a3a5c; padding: 24px; text-align: center;">
              <h1 style="color: white; margin: 0; font-size: 22px;">Ligue de Balle LBMA</h1>
            </div>
            <div style="padding: 32px 24px;">
              <p>Bonjour <strong>${prenom} ${nom}</strong>,</p>
              <p>Avant la saison 2026, nous vous demandons de vérifier et compléter votre fiche de joueur.</p>
              <p>Cliquez sur le bouton ci-dessous pour accéder à votre fiche personnelle. Vous pourrez y corriger vos coordonnées et ajouter toute information manquante.</p>
              <div style="text-align: center; margin: 32px 0;">
                <a href="${lien}"
                   style="background: #1a3a5c; color: white; padding: 14px 32px;
                          text-decoration: none; border-radius: 6px; font-size: 16px;
                          display: inline-block;">
                  Accéder à ma fiche →
                </a>
              </div>
              <p style="font-size: 13px; color: #888;">
                Ce lien est valide pendant 7 jours et ne peut être utilisé qu'une seule fois.<br>
                Si vous n'êtes plus actif dans la ligue, ignorez simplement ce message.
              </p>
            </div>
            <div style="background: #f5f5f5; padding: 16px; text-align: center; font-size: 12px; color: #999;">
              Ligue de Balle LBMA — liguelbma.org
            </div>
          </div>
        `,
      });

      resultats.push({ joueur: `${prenom} ${nom}`, statut: 'envoyé', courriel });
      await sleep(DELAY_MS);

    } catch (e) {
      resultats.push({ joueur: `${joueur.prenom} ${joueur.nom}`, statut: `erreur: ${e.message}` });
    }
  }

  const envoyes = resultats.filter(r => r.statut === 'envoyé').length;
  return res.status(200).json({ envoyes, total: joueursFiltres.length, resultats });
}
