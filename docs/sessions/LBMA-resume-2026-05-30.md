# LBMA — Résumé de session
**Date :** 30 mai 2026  
**Projet :** liguelbma.org (`schausse-hash/LBMA`)  
**Supabase :** `xgyskiatppgaeaamjhxr`  
**GitHub token :** `github_pat_*** (voir 1Password)`

---

## Vue d'ensemble

Session de **gestion de données joueurs** (pas de nouveau code applicatif, sauf le tutoriel) :
nettoyage d'un joueur en doublon, remplacement de 2 joueurs dans un roster, mise à jour du
tutoriel admin, et décision (reportée) sur un éventuel statut « blessé ».

---

## Fichiers modifiés

| Fichier | Modifications |
|---|---|
| `tutoriel.html` | **Nouvelle sous-section** « 🔄 Remplacer un joueur (blessure ou départ) » dans la section 4 (Gestion des Joueurs) + encadré « Supprimer » qui redirige vers Remplacer |

*(Commit : `ef8bfc9` — « Tutoriel: ajout procedure 'Remplacer un joueur (blessure/depart)' dans Gestion des Joueurs »)*

---

## 1. Fusion d'un joueur en doublon — Pat Eaglefield

Le joueur s'était inscrit sous plusieurs orthographes au fil des ans, ce qui fragmentait sa fiche
carrière en 3 « joueurs » distincts.

### Variantes trouvées et corrigées
| Table | Avant | Après | Lignes |
|---|---|---|---|
| `frappeurs_saison` | `EGGLEFIELD PATRICK` (×6) + `EGGLEFIELD PAT` (×1) | `EAGLEFIELD PAT` | 7 |
| `frappeurs_series` | `Patrick Egglefield` (×2) | `Pat Eaglefield` | 2 |

- Saison 2026 (`EAGLEFIELD PAT`) était déjà correcte.
- ⚠️ **`SCOFIELD DWAYNE` exclu** — joueur *différent* attrapé par la recherche `%field%`, non touché.
- Tables déjà correctes (non modifiées) : `pointage_frappeurs`, `equipes_saison`, `joueurs_liste`, `repechage_picks`.

### Pourquoi un simple renommage (pas une addition)
Chaque ligne de `frappeurs_saison` = **une saison unique** (pas de chevauchement). Donc renommer
suffisait, sans additionner de stats. `frappeurs_carriere` ne contient pas ce joueur → carrière
calculée dynamiquement, donc reconstituée automatiquement après uniformisation des noms.

### Stats carrière consolidées (résultat)
8 saisons (2012 → 2026) · 136 PJ · 417 AB · 162 CS · 114 s · 24 d · 17 t · 7 CC · 121 PC · 32 RB · 26 BB · **moy .388**

---

## 2. Remplacement de 2 joueurs — HARFANGS 2026

⚠️ **Correction en cours de route** : les 2 partants avaient été annoncés comme « DUCS », mais
ils étaient en réalité dans les **HARFANGS** (vérifié avant d'agir → erreur évitée).

| Slot (`ordre`) | Sortant | Cote | Remplaçant |
|---|---|---|---|
| 10 | `GARCIA EDGAR` | 2 | `MICHAUD JEAN-DAVID` |
| 11 | `OREILLY MYLES` | 1 | `FELX MICHEL` |

- Opération : `UPDATE equipes_saison` (position et cote du slot conservées) → roster reste à **11 joueurs**.
- **Équilibre de cotes préservé** : sortants 2+1 = 3 ; arrivants 2+1 = 3.
- Remplaçants confirmés présents dans `joueurs_liste` au bon format, et pas déjà inscrits ailleurs en 2026.
- Sortants : retirés du roster actif seulement → **carte + stats intactes** (rappelables plus tard).
- Note : `OREILLY` stocké sans apostrophe (l'apostrophe cassait des requêtes).

---

## 3. Décision reportée — Statut « blessé »

Idée évaluée : afficher un repère visuel pour les joueurs blessés sur la page Joueurs.

**Décision : reporté** (pas dans les priorités). Quand le sujet reviendra :

- ❌ **NE PAS réutiliser le champ `role`** pour mettre « blessé ». Le champ `role` fait déjà
  **3 jobs** : joueur/coach, classification lanceurs (`lanceur_a`, 38 joueurs), et permissions
  d'affichage (`admin`, `coachadmin`). Le surcharger effacerait le vrai rôle et casserait les
  comptes/filtres.
- ✅ **Voie sûre** = champ **dédié** (`blesse` oui/non) + petit badge « 🩹 Blessé » *à côté* du rôle.
  Ajouter une colonne est **additif** → ne touche aucune donnée existante.

---

## Règles établies (cette session)

1. **Fusion de doublons de nom** → *renommer* si chaque ligne est déjà une saison/équipe unique ;
   *additionner puis supprimer le doublon* seulement si deux lignes partagent la même saison.
2. **Format de nom EXACT** = `NOM PRÉNOM` en majuscules, identique partout. Une variante = un
   « joueur fantôme » dont les stats se coupent en deux. (À surveiller surtout à l'ajout d'un joueur.)
3. **Remplacer un joueur** → bouton **🔄** dans Équipes Saison (touche seulement `equipes_saison`).
   **Jamais supprimer** un joueur qui s'en va : il garde sa carte et ses stats.
4. **Vérifier la bonne équipe** avant toute modification de roster (un nom de famille peut exister
   dans plusieurs équipes).
5. **Un champ = une seule signification.** Ne pas mélanger « rôle » (ce qu'il est) et « statut »
   (son état temporaire).

---

## Procédure self-service (documentée dans `tutoriel.html` §4)

Remplacement d'un joueur, faisable par Sergio ou les coordonnatrices, **sans SQL** :

1. **Joueurs (Liste) → ➕ Ajouter Joueur** (si le remplaçant n'existe pas déjà)
2. **F5** pour rafraîchir
3. **Équipes Saison → 🔄** sur le sortant → choisir le remplaçant

---

## Prochaines étapes (optionnelles, non urgentes)

- [ ] Si besoin un jour : ajouter le champ `blesse` + badge sur la page Joueurs (voie sûre ci-dessus).
- [ ] (Reliquat sessions précédentes) Uploader photos d'équipe / joueurs 2026 via `admin-cartes.html`.

---

*Session réalisée via Claude (claude.ai) — push GitHub direct via API*
