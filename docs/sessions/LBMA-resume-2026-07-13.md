# Résumé LBMA — 2026-07-13

**Session : construction complète du système de séries éliminatoires 2026** (cédule, affichage public, gestion admin, pointage, stats et classement des séries).

> Contexte : le site est neuf depuis le repêchage d'avril 2026. C'est la **première fois** qu'on pointe des séries sur le site — le côté « séries » n'avait jamais servi et était à bâtir.

---

## 1. Cédule des séries 2026 (`matchs_series`)

17 matchs insérés (2026, `no_match` 1→17, ids 125→141), formule identique à 2025 :

- **Quarts (2 de 3)** — `R1-A` = #4 vs #5 · `R1-B` = #3 vs #6. Le mieux classé reçoit les matchs 1 et 3.
- **Demies (2 de 3)** — réensemencement : `R2-A` = #1 vs survivant le plus **bas**, `R2-B` = #2 vs survivant le plus **haut**.
- **Finale (3 de 5)** — le plus bas classé visite le plus haut, en alternance.
- **Départ samedi 22 août** (le régulier finit vendredi 21 août — dernière soirée régulière, donc les séries ne peuvent pas commencer le 21). Samedi 9h00/10h45 (Auteuil) · Vendredi 19h00/20h45 (Jarry 1). Terrains ajustables.
- Équipes en **placeholders par rang** (`6e`, `3e`, `Plus bas`, `Finaliste haut`…) + colonnes `seed_visiteur`/`seed_local` remplies quand connues. **À remplacer par les vraies équipes après le classement final du 21 août.**
- Matchs « si nécessaire » marqués dans `notes`.

> Convention `serie_id` alignée sur le formulaire admin : **R1-A = #4v#5, R1-B = #3v#6** (j'avais inversé au début, corrigé).

---

## 2. Affichage public — `calendrier.html`

- Les séries sont **intégrées dans la même liste de cartes** que le régulier (interclassées par date), avec un marqueur **`(s)`** doré + bordure gauche dorée.
- **Bouton filtre `🏆 Séries`** ajouté à côté des mois + mois **Oct**. `renderMatches()` combine `allGames` + `allSeries` ; filtre `currentFilter === 'SERIES'` = séries seulement.
- Boutons **📋 pointage** (`pointage.html?id=…&t=s`) et **📅 agenda** ajoutés sur les cartes de série. `goPointage(el,id,type)` ajoute `&t=` ; `openMatchPopup` cherche dans `allGames || allSeries`.
- L'ancienne section « bracket » (`renderSeriesSection`) est **débranchée** (plus de scroll en bas).
- **Décision** : le classement des séries **ne va PAS** dans la barre latérale du calendrier — il reste sur les pages Statistiques.

---

## 3. `pointage.html` — support des séries

- Nouveau paramètre d'URL **`?t=s`** → charge d'abord `matchs_series` (sinon `matchs_regulier`). Évite la **collision d'id** entre les deux tables (un id de série peut exister comme id régulier).
- Variable globale `mtype`. Le lien de retour login inclut le type.

---

## 4. Gestion admin — `admin.html`

- **Bug corrigé** : le bloc `calRegulier` n'était **pas fermé** (`</div>` manquant), donc `calSeries` était imbriqué dedans → l'onglet **🏆 Séries** apparaissait **vide** (le parent en `display:none` cachait l'enfant). Ajout du `</div>` → l'onglet fonctionne (formulaire d'ajout, tableau, ✏️/🗑️ par match).
- **Liens vers `stats-series-live.html`** ajoutés : barre latérale, tableau de bord, et bouton dans l'onglet Séries.

---

## 5. Pointage des séries — `stats-series-live.html`

Outil dédié aux séries (écrit dans les tables **de séries**, jamais celles du régulier). Il était orphelin/déconnecté ; branché sur la cédule :

- **Menu « Match cédulé »** rempli depuis `matchs_series` (statut avenir/en_cours). À la sélection : auto-remplit équipes + date, stocke `serieMatchId`. Avertit si l'équipe est encore un rang (`3e`/`6e`).
- **Finalisation** : si match cédulé → `sbPatch('matchs_series', …, {score, status:'final'})` ; sinon `series_matches` (fallback). Le **cumul dans `frappeurs_series`/`lanceurs_series`** est conservé.
- **Auto-déverrouillage** : si session `lbma_admin_session` valide (superadmin/admin/marqueur) → passe le mot de passe (comme stats-live). Sinon portail avec mots de passe codés : `marqueur` / `admin` / `lbma2026`.

> ⚠️ **Limite** : pas de table `pointage_*_series` → **refinaliser un match double-compte** les stats. Un match finalisé disparaît du menu (protection). Pour reprendre : remettre le match à `avenir` dans l'admin, puis corriger manuellement les stats.

---

## 6. Affichage stats séries

- **`stats-series.html`** : nouvel onglet **🏆 Classement** (à côté de Frappeurs/Lanceurs) — classement d'équipes des séries **par points** (V·2 + N), même format que la saison, calculé depuis `matchs_series` finals (équipes avec `pj>0` seulement). Le sélecteur « Année des séries » inclut maintenant les années de `matchs_series`. Les onglets Frappeurs/Lanceurs lisaient déjà les bonnes tables (`frappeurs_series`/`lanceurs_series`) → se rempliront automatiquement au pointage.
- **`stats-lanceurs.html`** : ajout de l'onglet **Séries Éliminatoires** (cohérence avec `stats-frappeurs.html` qui l'avait déjà).

---

## 7. Architecture des séries — DEUX tables (important)

- **`matchs_series`** = **la cédule** des séries (schedule + scores). `saison` **INTEGER**. Colonnes : `ronde, no_match, date, jour, heure, visiteur, local, score_*, endroit, status, notes, serie_id, serie_format, seed_*`. **Source de vérité**, utilisée par calendrier, admin, pointage, stats-series-live, et le classement séries.
- **`series_matches`** = ancienne table simplifiée (`saison` TEXT, pas de ronde/serie_id), **vide** — seulement un fallback de l'ancien stats-series-live. **À ignorer/déprécier.**
- **`frappeurs_series` / `lanceurs_series`** = stats cumulatives de séries (`saison` **TEXT**), alimentées par stats-series-live.

---

## 8. Pièges rencontrés

- **Troncature CRLF à l'édition** : l'outil d'édition tronquait la **fin** des gros fichiers HTML en CRLF (le `</body></html>` et des scripts disparaissaient → menu/page cassés en ligne). **Solution** : éditer via Python (normaliser LF ou préserver CRLF), et **toujours vérifier que le fichier finit par `</html>`** après édition. C'est ce qui avait fait disparaître le menu du calendrier une fois.
- **Lecture tronquée (artefact)** : `classement-equipes.html` et `stats-live.html` s'affichent coupés à la lecture, mais sont **intacts sur le disque** (même nb d'octets que HEAD, `core.autocrlf=true`). Sur la machine, `git status` les voit propres.
- **Git** : `git add .` / `git add -A` **interdits** (risque de commiter un fichier vu tronqué). Toujours `git add <fichier>` précis. `git config core.autocrlf true` recommandé (fait).

---

## 9. À faire / à surveiller

- **Après le 21 août** : remplacer les rangs (`3e`, `6e`, `Plus bas`…) par les vraies équipes dans `matchs_series` (via l'admin).
- **Avant les vraies séries** : nettoyer les données de test 2026 (remettre `matchs_series` 2026 à `avenir`/scores null + vider `frappeurs_series`/`lanceurs_series` 2026). Requête de nettoyage à préparer.
- **À vérifier** : `stats-series-live` écrit le `nom` au format **roster** (`NOM PRÉNOM`). L'historique `frappeurs_series` est en `Prénom Nom` (cf. Référence §4). Cohérent pour 2026 (tout en format roster), mais format différent de l'historique — à surveiller pour l'affichage.
- Optionnel : bracket/champion visuel ; protection anti-double-comptage (table `pointage_*_series`).

---

*Système de séries livré de bout en bout : cédule + calendrier public + admin + pointage + meneurs + classement. Reste à pointer les vraies parties (dès le 22 août) et nettoyer les tests.*
