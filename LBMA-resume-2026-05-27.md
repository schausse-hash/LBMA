# LBMA — Résumé de session
**Date :** 27 mai 2026  
**Projet :** liguelbma.org (`schausse-hash/LBMA`)  
**Supabase :** `xgyskiatppgaeaamjhxr`  
**GitHub token :** `github_pat_*** (voir 1Password)`

---

## Fichiers modifiés

| Fichier | Modifications |
|---|---|
| `carte-joueurs.html` | Fix iOS backface + luminosité impression |
| `admin-cartes.html` | Restauration version saine (bugs introduits corrigés) |
| `calendrier.html` | no_match fixe + affichage note report sous la date |
| `pointage.html` | Protection stats-live, avertissements, beforeunload |
| `stats-live.html` | Enregistrement source_saisie='stats-live' |
| `tutoriel.html` | Procédure officielle "Reporter un match" (section 6) |

---

## 1. Cartes de joueurs — Corrections iOS et impression

### iOS — Aigle inversé au verso
**Problème :** Sur iPhone/Safari, le logo de l'équipe du recto apparaissait à l'envers au verso (bug `backface-visibility`).  
**Fix :** Ajout de `-webkit-perspective` sur `.card-stage`, `-webkit-transform-style: preserve-3d` sur `.card-inner`, `will-change: transform` + `translateZ(0)` sur chaque `.card-face` pour forcer un calque GPU séparé.

### Impression — Photo trop foncée
**Fix :** Ajout dans `@media print` du filtre `img { filter: brightness(1.35) contrast(0.95) }` — la photo s'éclaircit automatiquement à l'impression sans affecter l'écran.

---

## 2. Matchs reportés — Numérotation et calendrier

### Report des 3 matchs du 18 mai
Les matchs initialement prévus le 18 mai (IDs 311, 312, 313) ont été déplacés au **vendredi 14 août 2026** :

| ID | no_match | Équipes | Heure |
|---|---|---|---|
| 311 | **#9** | CONDORS @ HARFANGS | 18H30 |
| 312 | **#10** | VAUTOURS @ AIGLES | 20H00 |
| 313 | **#11** | DUCS @ FAUCONS | 21H30 |

Note ajoutée : *"Reporté du 18 mai — pluie"*

### Numérotation fixe — Tous les 75 matchs 2026
**Problème :** Les numéros de match changeaient lors d'un report car `calendrier.html` utilisait `i+1` (position dans le tableau trié par date).  
**Fix Supabase :** Attribution du champ `no_match` (1 à 75) à tous les matchs 2026 selon leur ordre chronologique **original** (avant rescheduling). Les matchs reportés gardent leur numéro d'origine (#9, #10, #11) même déplacés en août.  
**Fix calendrier.html :** `g._numero = g.no_match || i+1` — utilise le champ fixe en priorité.

### Note de report dans le calendrier
La note du champ `notes` s'affiche maintenant sous la date dans `calendrier.html` (texte rouge italique, ex : *"Reporté du 18 mai — pluie"*).

### Procédure officielle de report (Tutoriel)
Ajoutée dans `tutoriel.html` → section 6 Calendrier :
- **Ne jamais** utiliser "Ajouter" pour un report (crée un nouveau numéro)
- **Toujours** modifier (✏️) la partie existante : changer date + Status "Reporté" + Note
- Quand la nouvelle date est connue : modifier à nouveau, remettre Status "À venir"

---

## 3. Migration RB (Retraits au Bâton) 2006-2019

### Source
Fichier Excel : `FRAPPEUR_CLASSEMENT_1976_A_2019.xlsx` (feuilles F2006 à F2019)

### Résultat
**778 UPDATE** exécutés en 8 lots dans `frappeurs_saison` pour tous les joueurs ayant des RB > 0 entre 2006 et 2019. Seuls les RB > 0 ont été mis à jour (les 0 laissés intacts pour ne pas écraser).

### Cas BELLIVEAU ÉRIC (2 L's)
- Dans l'Excel : `Béliveau` (1 L) → nom dans la BD : `BELLIVEAU ÉRIC` (2 L's)
- Les mises à jour du lot initial n'ont pas matché (mauvais nom)
- **Correction manuelle** avec les valeurs extraites directement de l'Excel pour 2010-2019
- **Doublons** : 2 lignes par saison pour ce joueur → les RB avaient été doublés. Fix : mise à 0 du RB sur les lignes doublons (IDs 18206-18214)

### Valeurs BELLIVEAU ÉRIC appliquées

| Saison | RB |
|---|---|
| 2010 | 18 |
| 2011 | 12 |
| 2012 | 11 |
| 2013 | 14 |
| 2014 | 4 |
| 2015 | 5 |
| 2016 | 8 |
| 2017 | 13 |
| 2018 | 8 |
| 2019 | 5 |

---

## 4. Corrections diverses Supabase

| Table | Correction |
|---|---|
| `frappeurs_saison` | BASSENDEN JAMES 2026 : PJ confirmé à **4** (3 matchs avec AB + 1 match DEF 0 AB le 22 mai) |
| `matchs_regulier` | Parties du 29 mai remises en `avenir` (erreur corrigée — elles n'étaient pas reportées) |
| `matchs_regulier` | Nouvelle colonne `source_saisie` (voir section 5) |

---

## 5. Fiabilité pointage.html — Protections ajoutées

### Problèmes identifiés
- **Effacement des stats** : Ouvrir un match finalisé via stats-live dans pointage, puis finaliser avec des valeurs incomplètes → deltas négatifs → soustraction des stats de `frappeurs_saison`
- **Doublons** : Finaliser deux fois le même match → stats doublées
- **Retour arrière** : Quitter sans sauvegarder → `pointage_frappeurs` modifié partiellement

### Solution — Colonne `source_saisie`
Nouvelle colonne `TEXT` dans `matchs_regulier` :
- `stats-live` → enregistré par stats-live.html lors de la finalisation
- `pointage` → enregistré par pointage.html lors de la finalisation
- `NULL` → match non encore finalisé (ou finalisé avant ce fix)

### Protections dans pointage.html

| Situation | Protection |
|---|---|
| `source_saisie = 'stats-live'` | ⛔ Bannière rouge bloquante + bouton Finaliser **désactivé** |
| Match déjà `final` (via pointage) | ⚠️ Bannière jaune + double confirmation obligatoire |
| Quitter sans sauvegarder | Alerte `beforeunload` du navigateur |
| Refinalisation | Confirmation explicite demandant de vérifier TOUS les joueurs |

### Stats-live.html
Enregistre désormais `source_saisie='stats-live'` dans `matchs_regulier` lors de la finalisation d'un match.

> **Note :** Les matchs finalisés *avant* ce fix ont `source_saisie = NULL` → bannière jaune (prudence) mais pas blocage.

---

## 6. Architecture — Résumé de l'état actuel

### Saisie des matchs
```
stats-live.html (outil principal)
  └── Finalise → source_saisie='stats-live'
  └── Écrit → pointage_frappeurs, pointage_lanceurs, frappeurs_saison, lanceurs_saison

pointage.html (outil admin secondaire)
  └── BLOQUÉ si source_saisie='stats-live'
  └── Finalise → source_saisie='pointage'
  └── Écrit → pointage_frappeurs via DELETE+INSERT puis delta vers frappeurs_saison
```

### Calendrier
```
matchs_regulier
  ├── no_match (1-75, fixe, jamais modifié lors d'un report)
  ├── date / heure / jour (modifiés lors d'un report)
  ├── status : avenir | en_cours | final | reporte | annule
  ├── notes : texte libre (ex: "Reporté du 18 mai — pluie")
  └── source_saisie : pointage | stats-live | NULL
```

---

## Règles établies aujourd'hui

1. **Reporter un match** → toujours ✏️ Modifier l'existant, JAMAIS Ajouter
2. **no_match** → ne JAMAIS modifier lors d'un report
3. **Stats-live vs pointage** → ne JAMAIS mixer les deux outils sur le même match
4. **Numéros 1-75** → saison 2026 complète numérotée, les matchs reportés conservent leur numéro original

---

*Session réalisée via Claude (claude.ai) — push GitHub direct via API*
