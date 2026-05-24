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
  ADD COLUMN IF NOT EXISTS photo_url        TEXT    DEFAULT '' NOT NULL,
  ADD COLUMN IF NOT EXISTS note_bio         TEXT    DEFAULT '' NOT NULL,
  ADD COLUMN IF NOT EXISTS numero_chandail  SMALLINT DEFAULT NULL,
  ADD COLUMN IF NOT EXISTS position         TEXT    NOT NULL DEFAULT 'Frappeur';
```

- `photo_url` — URL de la photo du joueur (Supabase Storage ou lien externe)
- `note_bio` — Texte biographique libre (max 400 caractères)
- `numero_chandail` — Numéro de chandail (ex: 33)
- `position` — Valeurs possibles : `Frappeur`, `Lanceur`, `Lanceur/Frappeur`, `Coach`, `Coach/Frappeur`

---

### 2. Supabase Storage — Bucket `joueurs-photos`
- Bucket public créé : `joueurs-photos`
- Taille max : 5 MB par fichier
- Types acceptés : `image/jpeg`, `image/png`, `image/webp`, `image/gif`
- Politiques RLS : lecture publique + upload/update/delete autorisés (anon)
- URL publique : `https://xgyskiatppgaeaamjhxr.supabase.co/storage/v1/object/public/joueurs-photos/<filename>`

---

### 3. Supabase RLS — Politique update `joueurs_liste`
```sql
CREATE POLICY "admin-update-joueurs-liste"
  ON joueurs_liste FOR UPDATE
  USING (true) WITH CHECK (true);
```

---

### 4. Couleurs CONDORS — changées en bleu
- Avant : brun/orange (`#3d1a00` / `#ff6b1a`)
- Après : bleu marine / bleu ciel (`#002d6b` / `#4d9fff`)
- Appliqué dans `carte-joueurs.html` et `admin-cartes.html`

---

### 5. Fichier `carte-joueurs.html` (page publique)
**URL :** `liguelbma.org/carte-joueurs.html`

Page publique de cartes de joueurs style baseball card :
- Source équipe officielle : `equipes_saison` (évite les doublons remplaçants)
- Stats agrégées toutes équipes confondues (remplaçants inclus dans le total)
- Tabs par équipe : AIGLES / CONDORS / DUCS / FAUCONS / HARFANGS / VAUTOURS
- Chips de sélection par joueur
- **Recto :** photo (ou mascot), numéro de chandail `#XX` en coin, nom, position, 4 stats (MOY / CC / PBR / MJ)
- **Verso :** photo vignette, bio (ville, naissance, âge, numéro, position), note bio, tableau stats complet
- Animation flip au tap/clic
- Responsive mobile
- Auto-sélection via paramètres URL : `?joueur=NOM&equipe=EQUIPE`
- Bouton **← Retour au site** (haut gauche)
- Bouton **🖨️ Imprimer** (haut droite) avec CSS print optimisé

---

### 6. Fichier `admin-cartes.html` (panneau admin)
**URL :** `liguelbma.org/admin-cartes.html`

Panneau admin protégé (`lbma_admin_session`) :
- Champ **numéro de chandail** (input numérique)
- Dropdown **position** : Frappeur / Lanceur / Lanceur/Frappeur / Coach / Coach/Frappeur
- Preview photo en temps réel
- Champ URL photo + bouton Upload vers bucket Supabase
- Textarea note bio (max 400 car.) avec compteur
- Bouton Enregistrer → UPDATE `joueurs_liste`
- Indicateurs visuels (point vert = rempli, point gris = vide)
- Toast de confirmation/erreur
- Couleurs CONDORS en bleu

---

### 7. Navigation — liens ajoutés

**Menu public (`index.html`) :**
- "Joueurs" transformé en dropdown :
  - 🏃 Liste des joueurs → `joueurs.html`
  - 🃏 Cartes de joueurs → `carte-joueurs.html`

**Menu admin (`admin.html`) :**
- Nouveau lien dans la sidebar : 🃏 Cartes Joueurs → `admin-cartes.html`

**Liste joueurs (`joueurs.html`) :**
- Chaque nom de joueur est cliquable → ouvre `carte-joueurs.html?joueur=NOM&equipe=EQUIPE` dans un **nouvel onglet**

---

### 8. Gestion des remplaçants
Problème : Joe Guerrera (AIGLES) et Sylvain Saint-Georges (CONDORS) avaient remplacé dans les HARFANGS → apparaissaient dans deux équipes.

Solution dans `carte-joueurs.html` :
- `equipes_saison` est la source officielle de l'équipe par joueur
- Stats de `frappeurs_saison` agrégées (toutes équipes sommées)
- Joueur affiché **seulement** sous son équipe officielle
- Automatique pour tous les futurs remplaçants toute la saison

---

## Fichiers GitHub modifiés/créés

| Fichier | Action | Description |
|---|---|---|
| `carte-joueurs.html` | Créé + mis à jour | Page publique cartes joueurs |
| `admin-cartes.html` | Créé + mis à jour | Panneau admin photos, numéros, positions |
| `admin.html` | Mis à jour | Lien Cartes Joueurs dans sidebar |
| `index.html` | Mis à jour | Dropdown Joueurs avec lien cartes |
| `joueurs.html` | Mis à jour | Noms cliquables → carte dans nouvel onglet |

---

## Architecture technique

```
liguelbma.org/carte-joueurs.html
  └── Supabase: equipes_saison (saison=2026) → équipe officielle
  └── Supabase: frappeurs_saison (saison=2026, ab>0) → stats agrégées
  └── Supabase: joueurs_liste (photo_url, note_bio, numero_chandail, position)

liguelbma.org/admin-cartes.html
  └── Auth: localStorage['lbma_admin_session']
  └── Supabase: joueurs_liste (UPDATE photo_url, note_bio, numero_chandail, position)
  └── Supabase Storage: bucket 'joueurs-photos' (upload fichiers)
```

---

## Prochaines étapes possibles
- Ajouter les stats de lanceur sur le verso pour les lanceurs
- Générer des cartes en PDF imprimables (toute une équipe d'un coup)
- Ajouter un numéro de chandail par joueur dans `joueurs_liste` pour tous les joueurs
- Intégrer un filtre par position dans `carte-joueurs.html`

---

## Token GitHub utilisé
PAT créé le 24 mai 2026 (nom: `claude_connect`) — expiration 30 jours.  
Repos couverts : `schausse-hash/LBMA`, `schausse-hash/dr-chausse-website`, `schausse-hash/facehub`.

---

*Session réalisée sur tablette (instance 1) + PC (instance 2) via Claude (claude.ai) — push GitHub direct via API*
