# LBMA — Résumé de session : Cartes de joueurs (suite)
**Date :** 26 mai 2026  
**Projet :** liguelbma.org (`schausse-hash/LBMA`)  
**Supabase :** `xgyskiatppgaeaamjhxr`  
**Suite de la session du 24 mai 2026**

---

## Fichiers modifiés

| Fichier | Rôle |
|---|---|
| `carte-joueurs.html` | Page publique cartes de joueurs |
| `admin-cartes.html` | Panneau admin photos & notes |

---

## Modifications — `carte-joueurs.html`

### Recto (devant)
- **Stats mini** : PJ · CS · PP · PC · MOY (5 colonnes, au lieu de MOY · CC · PP · PJ)
- **Numéro de chandail** en blanc à droite du nom (`CIARLO GINO  #14`)
- **Position auto** : "Lanceur/Frappeur" si le joueur apparaît dans `lanceurs_saison`
- Numéro retiré du coin de la photo (gardé seulement près du nom)

### Verso (endos)
- **Titre** : "CARRIÈRE" (au lieu de "CARRIÈRE AU BÂTON")
- **Haut** : Âge · Saisons (2 cellules)
- **Section CARRIÈRE** : PJ · CS · PP · PC · MOY (frappeur)
  - Si lanceur : rangée supplémentaire PL · V · D · MOY-L (% victoires)
- **Note biographique** (si renseignée)
- **Section SAISON 2026** :
  - Rangée 1 : PJ · AB · CS · 2B · 3B · CC · PP
  - Rangée 2 : CS/PJ · PC · BB · K · MOY (dans cet ordre)
  - Les deux bandes bleues ont la même couleur
- **Section LANCEUR 2026** (si applicable) : PL · V · D · MOY

### Terminologie corrigée
- MJ → **PJ** partout
- PBR → **PP** (Points Produits)
- CS/MJ → **CS/PJ**
- K = RB (Retraits au Bâton) ajouté dans saison 2026

### Requêtes Supabase
- **Pagination complète** pour les stats de carrière : boucle par blocs de 1000 lignes (comme `frappeurs-carriere.html`) pour obtenir les 30+ saisons
- Stats lanceurs 2026 : requête séparée `lanceurs_saison` filtrée sur saison=2026
- Limite Supabase de 1000 lignes contournée → carrières complètes

### Impression (`printCard`)
- Réécriture complète : recto/verso identiques à l'écran
- Fenêtre séparée avec boutons **🖨️ IMPRIMER** et **✕ FERMER**
- Plus d'auto-print (évite le blocage de la page principale au Cancel)
- `Ctrl+P` sur la page principale → page blanche + message d'instruction
- Hauteur recto = verso grâce à JS equalizer (plafonné à 380px, photo max 200px)
- `print-color-adjust: exact` pour les couleurs

---

## Modifications — `admin-cartes.html`

- **Source changée** : `repechage_picks` au lieu de `frappeurs_saison` → tous les joueurs du roster 2026 apparaissent, même sans AB

---

## Corrections de données Supabase

| Table | Correction |
|---|---|
| `frappeurs_saison` | CHAUSSÉ SERGE 2026 : PJ 6 → **5** (erreur de saisie) |
| `repechage_picks` | `BELLIVEAU ERIC` → **`BELLIVEAU ÉRIC`** (accent manquant causait une absence dans la carte) |
| `joueurs_liste` | Colonnes `photo_url` et `note_bio` ajoutées (session précédente) |
| `storage` | Bucket `joueurs-photos` avec RLS public |

---

## Architecture des données côté carte

```
fetchPlayers() charge en parallèle :
  ├── frappeurs_saison 2026 (ab>0)       → stats saison
  ├── joueurs_liste 2026                  → photo_url, note_bio, numero_chandail, position
  ├── repechage_picks 2026                → équipe officielle
  ├── fetchAllCareerBat()  ← pagination  → carrière frappeur (toutes saisons)
  ├── fetchAllCareerPit()  ← pagination  → carrière lanceur (toutes saisons)
  └── lanceurs_saison 2026                → stats lanceur saison en cours
```

---

## Structure du verso (ordre d'affichage)

```
┌─────────────────────────────────┐
│  NOM · Position · X saisons  📷 │  ← header
├──────────┬──────────────────────┤
│  Âge     │  Saisons             │  ← bio 2 colonnes
├─────────────────────────────────┤
│  ⚾ CARRIÈRE                    │
│  PJ · CS · PP · PC · MOY        │  ← batting carrière
│  PL · V  · D  · MOY-L           │  ← pitching carrière (si lanceur)
├─────────────────────────────────┤
│  Note biographique (italique)   │  ← si renseignée
├─────────────────────────────────┤
│  📅 SAISON 2026                 │
│  PJ · AB · CS · 2B · 3B · CC · PP │
│  CS/PJ · PC · BB · K · MOY     │
├─────────────────────────────────┤
│  ⚾ LANCEUR 2026 (si applicable)│
│  PL · V · D · MOY               │
├─────────────────────────────────┤
│  liguelbma.org          [LBMA]  │  ← footer
└─────────────────────────────────┘
```

---

## Couleurs des équipes (rappel)

| Équipe | Fond | Accent | Mascot |
|---|---|---|---|
| AIGLES | `#0a1f5e` | `#f5c518` | 🦅 |
| CONDORS | `#3d1a00` | `#ff6b1a` | 🦅 |
| DUCS | `#003d25` | `#6dff8a` | 🦆 |
| FAUCONS | `#5a0000` | `#ff4444` | 🦅 |
| HARFANGS | `#0b2a50` | `#8fd4ff` | 🦉 |
| VAUTOURS | `#240040` | `#cc77ff` | 🦅 |

---

## Prochaines étapes possibles
- Ajouter numéros de chandail dans `joueurs_liste` pour tous les joueurs
- Intégrer `carte-joueurs.html` dans le menu de navigation principal
- Ajouter un lien direct vers la carte d'un joueur depuis `stats-frappeurs.html`
- Générer un album PDF de toutes les cartes d'une équipe

---

*Session réalisée sur ordinateur via Claude (claude.ai) — push GitHub direct via API*  
*GitHub token : à renouveler si expiré*
