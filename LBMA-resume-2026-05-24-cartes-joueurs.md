# LBMA — Résumé de session : Cartes de joueurs
**Date :** 24 mai 2026  
**Projet :** liguelbma.org (`schausse-hash/LBMA`)  
**Supabase :** `xgyskiatppgaeaamjhxr`

---

## Ce qui a été fait

### 1. Supabase — Nouvelles colonnes (`joueurs_liste`)
Deux colonnes ajoutées à la table `joueurs_liste` :
```sql
ALTER TABLE joueurs_liste
  ADD COLUMN photo_url  TEXT DEFAULT '' NOT NULL,
  ADD COLUMN note_bio   TEXT DEFAULT '' NOT NULL;
```
- `photo_url` — URL de la photo du joueur (Supabase Storage ou lien externe)
- `note_bio`  — Texte biographique libre (max 400 caractères)

Pour mettre à jour un joueur manuellement :
```sql
UPDATE joueurs_liste
SET photo_url = 'https://...', note_bio = 'Texte bio...'
WHERE nom = 'CHAUSSÉ SERGE' AND saison = '2026';
```

---

### 2. Supabase Storage — Bucket `joueurs-photos`
- Bucket public créé : `joueurs-photos`
- Taille max : 5 MB par fichier
- Types acceptés : `image/jpeg`, `image/png`, `image/webp`, `image/gif`
- Politiques RLS : lecture publique + upload/update/delete autorisés (anon)
- URL publique d'un fichier : `https://xgyskiatppgaeaamjhxr.supabase.co/storage/v1/object/public/joueurs-photos/<filename>`

---

### 3. Supabase RLS — Politique update `joueurs_liste`
```sql
CREATE POLICY "admin-update-joueurs-liste"
  ON joueurs_liste FOR UPDATE
  USING (true) WITH CHECK (true);
```

---

### 4. Fichier `carte-joueurs.html` (page publique)
**URL :** `liguelbma.org/carte-joueurs.html`

Page publique de cartes de joueurs style baseball card :
- Chargement live depuis Supabase (`frappeurs_saison` 2026, join `joueurs_liste`)
- Tabs par équipe : AIGLES / CONDORS / DUCS / FAUCONS / HARFANGS / VAUTOURS
- Chips de sélection par joueur
- **Recto :** photo du joueur (ou mascot emoji si pas de photo), numéro, nom, équipe, 4 stats clés (MOY / CC / PBR / MJ)
- **Verso :** vignette photo, bio (ville, naissance, âge), note biographique, tableau complet (MJ, AB, CS, 2B, 3B, CC, PBR, MOY, PC, BB)
- Animation flip au tap/clic
- Responsive mobile

Colonnes utilisées depuis `frappeurs_saison` :
`nom`, `equipe`, `pj`, `ab`, `cs`, `simples`, `doubles`, `triples`, `cc`, `pc`, `pp`, `rb`, `bb`, `sac`, `moy`

---

### 5. Fichier `admin-cartes.html` (panneau admin)
**URL :** `liguelbma.org/admin-cartes.html`

Panneau admin protégé par `lbma_admin_session` (même auth que les autres pages admin) :
- Redirige vers `login.html` si non connecté
- Affiche tous les joueurs 2026 ayant des AB
- Filtres : tabs par équipe + barre de recherche par nom
- Par joueur :
  - **Preview photo** en temps réel
  - **Champ URL photo** (coller un lien)
  - **Bouton Upload** → upload direct vers bucket Supabase `joueurs-photos`, URL publique insérée automatiquement
  - **Textarea note bio** (max 400 car.) avec compteur
  - **Bouton Enregistrer** → UPDATE `joueurs_liste` (photo_url + note_bio)
  - Indicateurs visuels (point vert = rempli, point gris = vide)
  - Toast de confirmation/erreur
- La carte publique se met à jour instantanément après sauvegarde

---

## Fichiers GitHub modifiés/créés

| Fichier | Action | Description |
|---|---|---|
| `carte-joueurs.html` | Créé + mis à jour | Page publique cartes joueurs |
| `admin-cartes.html` | Créé | Panneau admin photos & notes |

---

## Architecture technique

```
liguelbma.org/carte-joueurs.html
  └── Supabase: frappeurs_saison (saison=2026, ab>0)
  └── Supabase: joueurs_liste (photo_url, note_bio, ville, naissance)

liguelbma.org/admin-cartes.html
  └── Auth: localStorage['lbma_admin_session']
  └── Supabase: joueurs_liste (UPDATE photo_url, note_bio)
  └── Supabase Storage: bucket 'joueurs-photos' (upload fichiers)
```

---

## Prochaines étapes possibles
- Ajouter la position (lanceur/frappeur) dans `joueurs_liste` pour l'afficher sur la carte
- Ajouter les stats de lanceur sur le verso pour les lanceurs
- Intégrer `carte-joueurs.html` dans le menu de navigation principal (`index.html`)
- Générer des cartes en PDF imprimables
- Ajouter un numéro de chandail par joueur dans `joueurs_liste`

---

*Session réalisée sur tablette via Claude (claude.ai) — push GitHub direct via API*
