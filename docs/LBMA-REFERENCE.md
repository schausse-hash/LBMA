# LBMA — Référence (document vivant)

> **À partager en début de session.** Remplace la relecture des résumés datés.
> Les résumés `LBMA-resume-AAAA-MM-JJ.md` restent l'archive chronologique (historique), mais les **règles durables** sont ici.
>
> *Dernière mise à jour : 13 juillet 2026.*

---

## 1. Identifiants & accès  

| Élément | Valeur |
|---|---|
| Dépôt GitHub | `schausse-hash/LBMA` (branche `main`) |
| Push | API GitHub Contents (fetch SHA → PUT) — token `github_pat_***` dans **1Password** |
| Supabase project | `xgyskiatppgaeaamjhxr` — `https://xgyskiatppgaeaamjhxr.supabase.co` |
| Production | www.liguelbma.org (déploiement Vercel auto, 1-2 min après push) |
| Dossier local | `C:\Users\schau\dev\LBMA` (anciennement `…\documents\applicationsweb\lbma`) |
| Analytics | Google Analytics `G-6ERJEBXPZW` ; bandeau consentement Loi 25 dans `lbma-analytics.js` |
| Google Maps | clé publique restreinte au domaine, dans `terrains.html` (Maps Static API) |

> Après un push : vérifier que la build Vercel est verte, puis **Ctrl+Shift+R** pour voir les changements.

---

## 2. Workflow de session

**Avant :** `git pull origin main` dans le dossier local.
**Pendant :** Claude lit/modifie les fichiers, exécute du SQL Supabase, audite RLS/policies — directement.
**Après :** vérifier le déploiement Vercel + hard refresh.

> **Mémoire :** Claude conserve maintenant une mémoire entre les sessions. Partager ce fichier de référence reste utile (la mémoire est un résumé, pas une copie complète), mais ce n'est plus obligatoire.
> **Sécurité :** aucune opération destructive (DROP/DELETE, suppression de joueur, etc.) sans confirmation explicite. Triple sauvegarde : GitHub + Supabase live + dump SQL local.

---

## 3. Architecture des données

### Saisie des matchs — deux outils, jamais mélangés
```
stats-live.html (outil principal)
  └─ finalise → source_saisie = 'stats-live'
  └─ écrit → pointage_frappeurs, pointage_lanceurs, frappeurs_saison, lanceurs_saison

pointage.html (admin secondaire)
  └─ BLOQUÉ si source_saisie = 'stats-live' (bannière rouge)
  └─ finalise → source_saisie = 'pointage'
  └─ écrit → pointage_frappeurs (DELETE+INSERT) puis delta vers frappeurs_saison
```
- `matchs_regulier.source_saisie` (`stats-live` | `pointage` | `NULL`). `NULL` = finalisé avant ce système → prudence (bannière jaune), pas de blocage.
- Protections `pointage.html` : blocage si stats-live, double confirmation si refinalisation, alerte `beforeunload`.

### Calendrier (`matchs_regulier`)
- `no_match` (1-75) = numéro **fixe**, attribué selon l'ordre chronologique **original**. **Jamais modifié** lors d'un report (le match garde son numéro même déplacé).
- `calendrier.html` : `g._numero = g.no_match || i+1`.
- `status` : `avenir` | `en_cours` | `final` | `reporte` | `annule`.
- `notes` : texte libre, affiché sous la date (rouge italique) — ex. « Reporté du 18 mai — pluie ».
- **Reporter un match** : toujours ✏️ **Modifier** l'existant (date + status + note), **jamais Ajouter** (créerait un nouveau numéro).
- `frappeurs_saison.saison` est **TEXT** ; `matchs_regulier.saison` est **INTEGER**.

### Séries éliminatoires (playoffs) — depuis 2026-07
- **`matchs_series`** = la **cédule** des séries (schedule + scores). `saison` **INTEGER**. Colonnes : `ronde, no_match, date, jour, heure, visiteur, local, score_*, endroit, status, notes, serie_id, serie_format, seed_visiteur/seed_local`. **Source de vérité** (calendrier, admin, pointage, stats-series-live, classement séries).
- ⚠️ **`series_matches`** = ancienne table simplifiée, **vide et dépréciée** — ne rien y écrire.
- **`serie_id`** : `R1-A` = #4 vs #5 · `R1-B` = #3 vs #6 · `R2-A` = #1 vs survivant bas · `R2-B` = #2 vs survivant haut · `FINALE`. Quarts/demies `2DE3`, finale `3DE5`.
- **Pointage des séries = `stats-series-live.html`** (jamais `stats-live.html`, régulier seulement). Écrit score/statut dans `matchs_series` + cumule dans `frappeurs_series`/`lanceurs_series`. Menu « Match cédulé » branché sur `matchs_series`. Auth = session `lbma_admin_session` (fallback mots de passe `marqueur`/`admin`/`lbma2026`).
- ⚠️ Pas de `pointage_*_series` → **refinaliser une série double-compte**. Un match final disparaît du menu ; pour reprendre, remettre à `avenir` puis corriger à la main.
- **Affichage** : `stats-series.html` (onglets Frappeurs / Lanceurs / **Classement**). Classement séries **par points** (V·2 + N) depuis `matchs_series` finals. **Pas** de classement séries au calendrier (décision).
- **Accès pointage** : bouton 📋 des cartes de série au calendrier → `pointage.html?id=…&t=s` (le `t=s` charge `matchs_series`, évite la collision d'id avec `matchs_regulier`).

### Rosters
- `repechage_picks` = **historique de repêchage immuable** (ne reflète pas les mouvements en cours de saison).
- `equipes_saison` = **roster vivant** (source de vérité pour l'équipe actuelle d'un joueur).
- **Remplacer un joueur** (blessure/départ) : bouton **🔄** dans Admin → Équipes Saison (touche seulement `equipes_saison`). **Jamais supprimer** un sortant : il garde sa carte et ses stats. Ajouter d'abord le remplaçant dans `joueurs_liste` au bon format.
- Toujours **vérifier la bonne équipe** avant de modifier un roster (un même nom de famille peut exister dans plusieurs équipes).

### Joueurs & statut « actif »
- **« Joueurs (Liste) »** et **« Joueurs Repêchage »** = **deux vues de la même table `joueurs_liste`**. Ajouter dans l'une ajoute dans l'autre (pas un bug).
- `joueurs_liste.actif` (booléen, défaut `true`). On l'active/désactive **uniquement** via « Joueurs Repêchage » (pas de doublon de bouton).
- `actif` pilote : bassin de repêchage, promotion vers la saison suivante, dropdowns roster, **et les envois de masse** (courriel + SMS + fiche excluent les inactifs).
- Effet de bord : désactiver un joueur le retire aussi de la promotion auto. Un blessé qui revient doit être **réactivé avant** la promotion de la prochaine saison.
- ⚠️ Ne **pas** réutiliser le champ `role` pour un statut « blessé » : `role` fait déjà 3 jobs (joueur/coach, classification lanceurs, permissions admin). Voie sûre = colonne dédiée `blesse` + badge (additif). *(Idée reportée, non urgente.)*

---

## 4. Conventions de noms de joueurs

- Format standard : **`NOM PRÉNOM` en MAJUSCULES**, identique partout. Une variante crée un « joueur fantôme » dont les stats se coupent en deux.
- Exceptions de format par table : `joueurs_equipe` = `Nom, Prénom` ; `frappeurs_series` = `Prénom Nom`.
- Apostrophes : stocker **sans** apostrophe (ex. `OREILLY`) — elles cassent des requêtes.
- Accents : indispensables (ex. `BELLIVEAU ÉRIC` ; un accent manquant a déjà fait disparaître un joueur d'une carte).
- **Fusion de doublons** : *renommer* si chaque ligne est déjà une saison/équipe unique ; *additionner puis supprimer* seulement si deux lignes partagent la même saison.

---

## 5. Couleurs des équipes

**Couleurs « site »** (source de vérité : `equipes.html` / `lbma-utils.js`) :

| Équipe | Couleur | Mascotte |
|---|---|---|
| AIGLES | `#FF8C00` | 🦅 |
| CONDORS | `#124FB2` | 🦅 |
| DUCS | `#006400` | 🦆 |
| FAUCONS | `#CC0000` | 🦅 |
| HARFANGS | `#929292` | 🦉 |
| VAUTOURS | `#330072` | 🦅 |

**Couleurs « cartes »** (palette distincte, dans l'objet `TEAMS` de `carte-joueurs.html`) :

| Équipe | bg | acc | light |
|---|---|---|---|
| AIGLES | `#5a3000` | `#FF8C00` | `#fff2e0` |
| CONDORS | `#002d6b` | `#4d9fff` | `#ddeeff` |
| DUCS | `#003d25` | `#6dff8a` | `#e6ffed` |
| FAUCONS | `#5a0000` | `#ff4444` | `#fff0f0` |
| HARFANGS | `#2b2e33` | `#cfd5db` | `#eef0f2` |
| VAUTOURS | `#240040` | `#cc77ff` | `#f4eeff` |

---

## 6. Cartes de joueurs (`carte-joueurs.html`)

- **Poste** dérivé de `car_pl > 0` → « Frappeur / Lanceur », sinon « Frappeur ». Affiché identiquement recto écran / verso / impression.
- **Texte blanc** partout (labels, sous-titres, footer), **sauf HARFANGS** (argent) et DUCS/HARFANGS au verso (gardent l'accent).
- **Impression** : cartes **240×368 fixes** recto = verso (découper / coller dos à dos) ; footer collé au bas ; photo recto remplit l'espace ; `print-color-adjust:exact` ; photo éclaircie via `filter:brightness(1.35)`.
- **Verso** (ordre) : header (nom · poste · X saisons · photo) → Âge / Saisons → CARRIÈRE (PJ·CS·PP·PC·MOY, + PL·V·D·MOY-L si lanceur) → note bio → SAISON 2026 (2 rangées) → LANCEUR 2026 (si applicable) → footer liguelbma.org / LBMA.
- **Données chargées** par `fetchPlayers()` : `frappeurs_saison` 2026, `joueurs_liste` (photo/note/numéro), `equipes_saison` (équipe officielle), carrière frappeur + lanceur (paginées), `lanceurs_saison` 2026.
- iOS : `-webkit-perspective` / `preserve-3d` / `translateZ(0)` pour éviter le logo inversé au verso.

---

## 7. Pièges Supabase à retenir

1. **Pagination > 1000 lignes** → toujours un départage **unique** (`id.asc`) après le tri principal (sinon lignes sautées en frontière de lot). Seule `frappeurs_saison` (3136 lignes) est concernée aujourd'hui.
2. **SQL multi-instructions** via `execute_sql` → ne renvoie que le résultat de la **dernière** instruction. Lancer les requêtes de vérification séparément.
3. **RLS** : `admin_users` verrouillée, auth via RPC bcrypt `SECURITY DEFINER`. Système de rôles `marqueur/coach/admin/superadmin` via `lbma_admin_session` (localStorage).
4. Échéance **30 octobre 2026** : Supabase verrouille les nouvelles tables par défaut → toute nouvelle table doit suivre le template `LBMA-template-nouvelle-table.sql`.

---

## 8. Pièges édition HTML & git (CRLF)

1. **Troncature à l'édition** : éditer un gros fichier HTML **CRLF** peut tronquer sa **fin** (`</body></html>` + scripts disparaissent → page cassée en ligne). Éditer via script (normaliser LF ou préserver CRLF) et **toujours vérifier que le fichier finit par `</html>`** avant de pousser.
2. **Lecture tronquée (artefact)** : certains gros fichiers (`classement-equipes.html`, `stats-live.html`) s'affichent parfois coupés à la lecture alors qu'ils sont **intacts sur le disque**. Comparer le nb d'octets à `git show HEAD:` pour trancher.
3. **`git add .` / `git add -A` interdits** — toujours `git add <fichier>` précis. `git config core.autocrlf true` (fait).

---

## 9. Règles d'or (synthèse)

1. **Reporter un match** → ✏️ Modifier, jamais Ajouter ; `no_match` jamais touché.
2. **stats-live vs pointage** → jamais les deux sur le même match.
3. **Statut joueur** → activer/désactiver via « Joueurs Repêchage » seulement ; désactiver = hors repêchage + promotion + envois.
4. **Remplacer un joueur** → 🔄 Équipes Saison ; jamais supprimer.
5. **Format de nom** → `NOM PRÉNOM` majuscules, identique partout ; vérifier la bonne équipe avant d'agir.
6. **Un champ = une seule signification** (ne pas mélanger rôle et statut).
7. **Pagination Supabase** → départage unique obligatoire au-delà de 1000 lignes.
8. **Navigation** → éditer `lbma-nav.js` seulement.
9. **Poste de carte** → `car_pl`, jamais `position`.
10. **Photos d'équipe** → format `EQUIPE_ANNEE.jpg`, jamais écrasées.
11. **Séries** → pointer via `stats-series-live.html` (jamais stats-live) ; `matchs_series` = cédule, `series_matches` déprécié.
12. **Git/édition** → jamais `git add .` ; vérifier que le fichier finit par `</html>` après édition d'un gros HTML.
