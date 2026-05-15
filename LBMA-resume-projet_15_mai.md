# RÉSUMÉ PROJET LBMA — liguelbma.org

*Mis à jour : 15 mai 2026 (matin + après-midi)*

---

## 1. ARCHITECTURE GÉNÉRALE

**Stack** : HTML/CSS/JS vanilla, Supabase (PostgreSQL), Vercel, auth bcrypt via RPC, 5 niveaux de rôles.

**Rôles** : superadmin, admin, marqueur, lecteur, public. + **coach** (accès limité).

**Tables Supabase (38 tables)** :
- **Priorité 1 — Données critiques** : `frappeurs_saison`, `lanceurs_saison`, `matchs_regulier`, `matchs_series`, `joueurs`, `joueurs_liste`, `equipes_saison`, `frappeurs_carriere`, `lanceurs_carriere`, `frappeurs_series`, `lanceurs_series`
- **Priorité 2 — Référence** : `saison_info`, `alertes`, `fiche_tokens`, `classements`, `champions`, `records_frappeurs_saison`, `records_lanceurs_saison`, `repechage_picks`, `series_matches`, `temple_membres`, `temple_batisseurs`, `temple_trophees`, `pointage_*`, `stats_match_*`
- **Priorité 3 — Admin/config** : `admin_users`, `page_config`, `direction_contacts`, `contacts`, `medias_articles`, `medias_podcasts`, `birthday_emails_sent`, `visites`

---

## 2. NOUVEAUTÉS — SESSION 20 AVRIL 2026

### 2.1 Bug export Excel corrigé ✅
- Fonction `exportJoueursExcel` était imbriquée à l'intérieur de `printJoueursList` (problème de scope JavaScript)
- Fix : déplacement de la fonction au niveau global, avant `printJoueursList`
- **Concept clé** : une fonction déclarée à l'intérieur d'une autre est inaccessible globalement

### 2.2 Policies RLS alertes corrigées ✅
- `alertes_delete` et `alertes_update` avaient `auth.role() = 'authenticated'` — bloquait les opérations car `admin.html` utilise la clé **anon**
- Fix : toutes les policies mises à `USING (true)` / `WITH CHECK (true)`

### 2.3 Suppression du Générateur CALENDRIER_DATA ✅

### 2.4 Post-repêchage complété ✅
- Repêchage du 18 avril — 6 équipes de 11 joueurs formées

### 2.5 Scripts fin de saison sauvegardés dans Supabase ✅
- `Fin saison 2026 - MAJ carrières frappeurs` et `Fin saison 2026 - MAJ carrières lanceurs`

---

## 2b. NOUVEAUTÉS — SESSION 28 AVRIL 2026

### 2b.1 Bug substitut inter-équipes corrigé (stats-live.html) ✅
### 2b.2 Erreur `renderCalendar is not defined` corrigée ✅
### 2b.3 Nettoyage résidus frappeurs_saison 2026 ✅
### 2b.4 Parcs (endroits) dynamiques dans admin.html ✅
### 2b.5 Liens Google Maps sur les parcs (calendrier.html) ✅
### 2b.6 Regroupement substituts dans stats-frappeurs.html ✅

---

## 2c. NOUVEAUTÉS — SESSION 5 MAI 2026

### 2c.1 PWA (Progressive Web App) complétée ✅
- Fichiers : `manifest.json`, `sw.js`, `apple-touch-icon.png`, `icon-192.png`, `icon-512.png`
- Installation iPhone : Safari → liguelbma.org → Partager → Sur l'écran d'accueil

---

## 2d. NOUVEAUTÉS — SESSION 10 MAI 2026

### 2d.1 Normalisation nom BELLIVEAU ÉRIC ✅
- 4 variantes corrigées dans `joueurs_liste`, `equipes_saison`, `frappeurs_saison`
- 9 saisons historiques (2010–2019) migrées du JSON vers `frappeurs_saison`

---

## 2e. NOUVEAUTÉS — SESSION 11 MAI 2026

### 2e.1 Colonne SAC ajoutée dans stats-live.html ✅
### 2e.2 Corriger match — interface originale réouverte ✅
### 2e.3 `annulerMatch` corrigé ✅
### 2e.4 Rôles ABS/OFF/DEF sauvegardés dans pointage_frappeurs ✅
### 2e.5 Lanceurs fantômes éliminés ✅
### 2e.6 pointage.html — logique delta pour finaliser ✅
### 2e.7 Nettoyage données 2026 ✅
### 2e.8 Temple de la Renommée — photos et biographies ✅
### 2e.9 tutoriel.html — mots de passe masqués ✅
### 2e.10 Regroupement substituts dans stats-live.html (onglet Stats Joueurs) ✅
### 2e.11 Colonne SAC ajoutée dans l'onglet Stats Joueurs de stats-live.html ✅
### 2e.12 Rôle ABS modifiable dans l'interface Corriger Match ✅

---

## 2f. NOUVEAUTÉS — SESSION 13 MAI 2026

### 2f.1 Bug substituts dans archives-frappeurs.html corrigé ✅
- Stabile John et Jean-Lachapelle Jérémie apparaissaient en double (2 lignes dans `frappeurs_saison`)
- Fix : ajout d'un `seasonPlayerMap` dans `loadFromSupabase()` — agrège les stats par `saison|nomNormalisé`
- L'équipe affichée est forcée vers l'équipe officielle (repêchage) via `equipesMap`
- **Concept clé** : même logique que `stats-frappeurs.html` (`buildAggregated`) — regrouper par nom avant affichage

### 2f.2 Tri unifié sur les 3 pages de stats frappeurs ✅
- Problème : les 3 pages (`stats-frappeurs`, `stats-live`, `archives-frappeurs`) triaient par MOY desc mais brisaient les égalités différemment → ordre incohérent
- Fix identique sur les 3 pages : **MOY desc → CS desc → AB desc → NOM asc**
- `stats-frappeurs` : `sortFn()` étendue avec bloc `if(sortCol==='moy')` + tiebreaker NOM asc pour toutes les colonnes
- `stats-live` : `merged.sort()` dans `renderPlayersStats()` mis à jour
- `archives-frappeurs` : nouvelle fonction `sortPlayers()` remplace les deux `.sort()` simples
- **Concept clé** : sans tiebreaker secondaire, JS.sort() brise les égalités selon l'ordre d'insertion Supabase — non déterministe entre pages

### 2f.3 Highlights leaders sur toutes les colonnes (sauf PJ) ✅
- **Avant** : seulement CS, CC, PP, MOY highlightés en doré dans `stats-frappeurs`
- **Après** : AB, CS, 1B, 2B, 3B, CC, PC, PP, SAC, BB, RB, MOY — sur les 3 pages
- `stats-frappeurs` : refactorisé avec fonction `h(val, max)` — une ligne par colonne, facile à maintenir
- `stats-live` : ajout CSS `.standings-table .highlight` + calcul des 12 maximums
- `archives-frappeurs` : classe `cell-leader` distincte (opacité .35 vs .20 pour compatibilité avec autres styles)
- Suppression du highlight top-10 (rangées entières dorées) dans `archives-frappeurs` — incohérent avec les autres pages

### 2f.4 Ordre des colonnes harmonisé : PP → SAC → BB → RB ✅
- `stats-frappeurs` et `stats-live` avaient SAC en fin de tableau ; `archives-frappeurs` l'avait déjà au bon endroit
- Fix headers HTML + ordre des `<td>` dans le rendu JS des deux fichiers

### 2f.5 Nouvelle page `benchage.html` ✅
- Tableau de suivi des benchages par équipe, saison en cours uniquement
- **Auth** : lit `localStorage['lbma_admin_session']` — même pattern que `admin.html`, redirect vers `login.html` si invalide
- **Accès** : coach, admin, superadmin uniquement
- **Données** : `pointage_frappeurs` via IDs de `matchs_regulier` (status=final) + `matchs_series`, filtrés par saison active (`saison_info`)
- Seuls les matchs de l'équipe officielle du joueur comptent (subs ignorés)
- **Tableau par équipe** : joueur / OFF / DEF / Total bench / Statut
- **Statuts descriptifs** (non prescriptifs) : 🟢 Le moins benché · 🟡 Intermédiaire · 🔴 Le plus benché · ✓ Égal
- **Alerte rouge** si écart > 1 dans une équipe (violation du règlement = défaite automatique)
- Auto-refresh toutes les 2 minutes
- Reset automatique en fin de saison : quand `saison_active` change, la page repart à zéro
- **Note règlement affichée** : l'outil est informatif — stats-live ne vérifie pas la rotation automatiquement
- **Concept clé** : "Le plus benché" n'est pas une interdiction absolue — si le nb de spots requis > joueurs au minimum, on doit obligatoirement prendre parmi ceux qui ont déjà benché

### 2f.6 Lien Benchage ajouté dans admin.html ✅
- Section **Live** du menu latéral : `⚖️ Benchage` → `benchage.html`
- Visible pour tous les rôles (benchage.html a sa propre vérification d'accès)

---

## 2g. NOUVEAUTÉS — SESSION 14 MAI 2026

### 2g.1 Nouvelle page `stats-match.html` — Stats détaillées par partie ✅
- Inspiré de marqueurs.com : chaque match final a un bouton **STATS** dans `calendrier.html`
- URL partageable : `stats-match.html?id=X` — bookmarkable, envoyable par texto/Facebook
- **Pourquoi une page séparée et non un modal** : URL partageable, persistance, simplicité de code

**Structure de la page :**
- En-tête : date + heure + score final (gagnant en surbrillance)
- Tableau **FRAPPEURS** équipe visiteur : AB, CS, 1B, 2B, 3B, CC, PC, PP, BB, SAC, K, MOY
- Tableau **FRAPPEURS** équipe local : idem
- Section **LANCEURS** par équipe (bas de page) : V/D/N, ML, CS, BB, K, PC, **PM**, MOY

**Sources de données :**
- `matchs_regulier` → infos du match (équipes, score, date)
- `pointage_frappeurs?match_id=eq.X` → stats frappeurs
- `pointage_lanceurs?match_id=eq.X&order=ordre.asc` → tous les lanceurs (partant + releveurs)

**Colonne lanceurs — détails :**
- **PM = Points Mérités** (colonne `er` dans la BD) — terminologie correcte utilisée par marqueurs.com
- **PC vs PM** : PC = tous les points accordés (incluant erreurs défensives) ; PM = seulement les points dont le lanceur est responsable
- **V/D/N** : seulement le lanceur partant (idx=0) reçoit la victoire ou défaite ; releveurs ont des tirets
- **Releveurs** : si plusieurs lanceurs dans `pointage_lanceurs`, tous apparaissent en lignes distinctes dans l'ordre (ordre.asc)

**Bouton STATS dans calendrier.html :**
- Nouvelle colonne `mc-stats` dans chaque `match-card`
- Visible seulement quand `status === 'final'`
- Clic → ouvre `stats-match.html?id=X`

**Concept clé** : `pointage_lanceurs` est ordonné par `ordre` — le partant est toujours idx=0, les releveurs suivent. La logique V/D/N s'applique uniquement sur le premier lanceur de chaque équipe.

---

## 2h. NOUVEAUTÉS — SESSION 15 MAI 2026

### 2h.1 Sécurisation de la table `admin_users` ✅
- **Contexte** : Supabase annonce qu'à partir du 30 octobre 2026, les nouvelles tables `public` nécessiteront des `GRANT` explicites pour la Data API. Audit complet des 38 tables effectué.
- **Vulnérabilité identifiée** : policy `superadmin_only` sur `admin_users` était `USING (true)` pour `{public}` — n'importe qui avec la clé anon pouvait lire les hashs bcrypt via une requête HTTP directe.
- **Solution appliquée** :
  1. Création de 2 RPCs SECURITY DEFINER : `list_admin_users()` (retourne id/username/nom/role/equipe, JAMAIS password_hash) et `delete_admin_user(p_id)` (avec garde-fou : impossible de supprimer le dernier superadmin)
  2. `admin.html` modifié : `loadUsersSB()` et `deleteUser()` passent maintenant par les RPCs au lieu de `sbFetch('admin_users?...')` direct. Backup conservé sous `admin_backup.html` sur GitHub.
  3. Policy verrouillée : `DROP POLICY "superadmin_only"` puis `CREATE POLICY "service_role_only_admin_users" USING (auth.role() = 'service_role')`. Plus `REVOKE ALL FROM anon, authenticated`.
- **Vérification finale** : login + édition utilisateurs testés en mode incognito, tout fonctionne.
- **Concept clé** : la clé anon Supabase est publique par design — la sécurité dépend 100% des policies RLS et des RPCs SECURITY DEFINER. Le nom d'une policy n'a aucun effet ; seule la condition `USING` compte.

### 2h.2 Audit complet des policies RLS ✅
- Script `LBMA-audit-grants.sql` créé pour vérifier l'état des permissions sur les 38 tables (5 requêtes ciblées : vue d'ensemble, tables sans GRANT anon, tables sans RLS, tables critiques, liste des policies).
- **Observations secondaires non corrigées** (faible priorité) :
  - Beaucoup de policies redondantes `{anon}` + `{public}` sur la même opération (concept : `public` inclut tous les rôles dont `anon`)
  - Policies "Admins seulement" sur `joueurs` et `contacts` contournées par les policies "Lecture publique" qui coexistent (concept : policies RLS additives en OR, pas AND)

### 2h.3 Template SQL pour nouvelles tables ✅
- Fichier `LBMA-template-nouvelle-table.sql` créé — réflexe à intégrer pour toute nouvelle table créée après le 30 octobre 2026 (date où Supabase fermera le schéma `public` par défaut sur les projets existants).
- 3 scénarios documentés : lecture publique totale (stats), lecture+écriture via anon (pattern `alertes`), privé par utilisateur (futur Supabase Auth).

---

## 2i. NOUVEAUTÉS — SESSION 15 MAI 2026 (après-midi)

### 2i.1 Infrastructure de travail Claude Cowork ✅
- **Connecteur Supabase MCP installé** — Claude peut maintenant interroger et modifier les 3 projets Supabase directement (LBMA, dentiste.com, FaceHub) sans copier-coller
- **3 dossiers locaux connectés** à Cowork — Claude lit et modifie les fichiers du repo directement
- **Workflow documenté** dans `WORKFLOW-SERGIO.md` (à la racine du repo LBMA)

### 2i.2 Sécurisation FaceHub complète ✅
Session de remédiation de 30-45 min sur facehub.ca :
- 14 tables médicales sécurisées via architecture RLS hiérarchique par clinique
- 2 fonctions SECURITY DEFINER créées (`current_user_is_staff()`, `current_user_clinic_id()`) pour éviter la récursion
- Préalable au sprint 3 (collaborateurs externes Emilie/Theresa/Dr Youssef) maintenant complété
- **Documentation dans le repo facehub** : `sql/SECURITE-15mai2026.md`, `sql/dump-securite-15mai2026.sql`, `sql/rollback-policies-15mai2026.sql`

### 2i.3 Fine-tuning dentiste.com ✅
- `ma_vie_videos` : policies "Auth" avec `USING(true)` corrigées → `auth.uid() IS NOT NULL`
- `analytics_events` et `visites` : lecture publique remplacée par `is_editor_or_admin()` (conformité Loi 25 — user_agent peut être identifiant)
- `services` : policy permissive `Admin can update services USING(true)` supprimée (annulait `services_editor_admin_all`)
- **Documentation dans le repo dr-chausse-website** : `sql/SECURITE-15mai2026.md`, `sql/dump-securite-15mai2026.sql`, `sql/rollback-policies-15mai2026.sql`

### 2i.4 Dump complet LBMA ✅
- Fichier `lbma/sql/dump-securite-15mai2026.sql` créé — 1628 lignes
- Contient : 5 RPCs SECURITY DEFINER (login_user, list_admin_users, delete_admin_user, save_user, change_password) + 182 policies + ENABLE RLS sur 39 tables
- Idempotent (DROP IF EXISTS + CREATE) — peut être réexécuté sans erreur
- En tête du fichier : note explicative sur le choix de design LBMA (auth client-side + USING(true) volontaire sur la majorité des tables)

### 2i.5 Concepts clés appris dans la journée
- **Récursion RLS** : si une policy interroge la même table qu'elle protège → risque de récursion. Solution : fonctions SECURITY DEFINER qui contournent RLS.
- **Policies en OR** : plusieurs policies sur la même opération = OR logique. Pour AND, mettre les conditions dans la même policy.
- **`auth.role()` vs `user_roles`** : le rôle Postgres (`anon`/`authenticated`/`service_role`) ≠ rôle métier (`super_admin`, `owner`, etc.) stocké en base.
- **Loi 25** : `user_agent`, `session_id`, IP peuvent être considérés comme identifiants → à restreindre.
- **`.env` ne doit JAMAIS être tracké par Git** — `.gitignore` mis à jour sur facehub pour bloquer ça.

---

## 3. PROCÉDURES OPÉRATIONNELLES

### 3.1 Marquage des parties (stats-live.html)
- Sélectionner le match → Démarrer → Entrer stats → Terminer Match
- Colonnes disponibles : AB, CS, 1B, 2B, 3B, CC, PC, PP, **SAC**, BB, K
- Lanceurs : OUT, PC, CS, BB, RB

### 3.2 Corriger un match après saisie
1. Stats Live → Matchs récents → ✏️ Corriger
2. L'interface originale s'ouvre pré-remplie
3. Modifier ce qui est nécessaire
4. **💾 Sauvegarder Correction** (vert) — les deltas sont appliqués automatiquement
5. **❌ Annuler** pour annuler la correction sans rien changer

### 3.3 Rôles joueurs dans un match
- **ABS** : absent — stats désactivées, badge rouge
- **OFF** : offensif seulement — bat, ne joue pas en défense
- **DEF** : défensif seulement — ne bat pas, joue en défense
- ⚠️ En mode **Corriger Match**, le dropdown de rôle reste actif même pour un joueur ABS

### 3.4 Remplacement d'un joueur blessé
1. Admin → Joueurs (Liste) → Ajouter Joueur (le remplaçant)
2. F5 pour rafraîchir
3. Équipes Saison → 🔄 sur le blessé → choisir le remplaçant
- ✅ Les stats du blessé dans `frappeurs_saison` sont **intactes**
- ❌ Ne pas supprimer le joueur blessé de `joueurs_liste`

### 3.5 Gestion des alertes (calendrier public)
- Admin → Calendrier → Alertes & Bannières
- Types : pluie, annulé, info, urgent
- Bouton SMS envoie via Twilio à tous les joueurs 2026

### 3.6 Temple de la Renommée
- Admin → Temple → ✏️ sur un bâtisseur/trophée/membre
- Remplir Biographie + uploader une photo → 💾 Sauvegarder

### 3.7 Suivi du benchage (benchage.html)
- Admin → Live → ⚖️ Benchage (ou URL directe)
- Accès : coach, admin, superadmin
- Affiche les totaux OFF + DEF par joueur par équipe, saison en cours
- Alerte si écart > 1 → corriger avant la prochaine partie (défaite automatique sinon)
- Règle : écart max de 1 entre joueurs, cumul saison régulière + séries, repart à 0 l'année suivante

### 3.8 Consulter les stats d'un match (stats-match.html)
- Calendrier public → bouton **STATS** sur un match final
- Ou URL directe : `stats-match.html?id=X`
- Affiche frappeurs des deux équipes + lanceurs (partant + releveurs)
- URL partageable par texto, courriel, Facebook

---

## 4. CONFORMITÉ LOI 25 ✅ (complétée 5 avril 2026)

| Élément | Statut |
|---|---|
| Page `confidentialite.html` | ✅ |
| Bannière consentement cookies | ✅ |
| Lien Politique dans tous les footers | ✅ |
| Google Analytics conditionnel | ✅ |

Responsable : Michel Plante (michelpla@videotron.ca)

---

## 5. SYSTÈME COURRIEL ANNIVERSAIRE ✅

- pg_cron : `send_birthday_emails()` tous les jours à 13h00 UTC (9h00 AM Montréal)
- Protection anti-doublon via `birthday_emails_sent`
- 100% dynamique — fonctionnera en 2027+ sans modification

---

## 6. FICHIERS VERCEL FUNCTIONS (api/)

| Fichier | Description |
|---|---|
| `api/send-email.js` | Courriel de masse — from: `noreply@liguelbma.org`, reply-to: `michelpla@videotron.ca` |
| `api/send-fiche.js` | Fiche joueur — token UUID, `fiche_tokens`, lien unique via Resend |
| `api/send-sms.js` | SMS de masse via Twilio — préfixe `LBMA - Michel Plante :` |

---

## 7. INTÉGRATION FACEBOOK — Planifiée

1. Créer app sur developers.facebook.com → Other → Business
2. Générer Page Access Token via Graph API Explorer
3. Créer `api/post-facebook.js` (Vercel Serverless Function)
4. Ajouter panneau Facebook dans `admin.html`
⚠️ Token expire ~60 jours — token longue durée requis

---

## 8. PROCHAINES SESSIONS — PRIORITÉS

### 🔴 Haute priorité
- Sauvegarde complète : repo GitHub (ZIP) + export CSV Supabase
- Séries 2024 absentes : à importer dans `matchs_series`

### 🟡 Moyenne priorité
- Intégration Facebook — publications automatiques
- Bouton envoi individuel pour fiche joueur
- Étendre `sb-client.js` : `stats-live.html`, `repechage-live.html`, `login.html`
- BB manquants frappeurs 1988-2004
- Équipes 2018-2019 dans `frappeurs_series`

### 🟢 Basse priorité
- Migration vers Supabase Auth
- og:image par article blog (dentiste.com)

---

## 9. NOTES TECHNIQUES CLÉS

| Sujet | Note |
|---|---|
| Supabase URL | `https://xgyskiatppgaeaamjhxr.supabase.co` |
| Google Analytics LBMA | `G-6ERJEBXPZW` |
| Saison active | `UPDATE saison_info SET valeur = '2027' WHERE cle = 'saison_active'` |
| `LBMA_CONFIG` | `MAX_JOUEURS_PAR_EQUIPE` (11), `NB_EQUIPES` (6), `NB_RONDES` (MAX-2) |
| `sbFetch()` admin.html | Clé anon. Retourne Response brute. Toujours : `res.ok ? await res.json() : []` |
| `confirm()` admin.html | Modal custom — pattern callback. Jamais `if(!confirm(...))return` |
| RLS alertes | Policies `USING (true)` — clé anon, pas Supabase Auth |
| Scope JS | Fonctions `onclick=""` → niveau racine du script obligatoire |
| PWA | `manifest.json`, `sw.js`, icônes à la racine. Balises dans `<head>` de `index.html` |
| `pointage_frappeurs` | Colonnes stats par match : `ab, h, r, rbi, b1, b2, b3, cc, bb, sac, k` + rôles `abs, off, def` |
| `endCorrectionMatch` | Delta = nouvelle valeur − ancienne valeur dans `pointage_frappeurs`. PJ non modifié. |
| `finaliser()` pointage | `wasAlreadyFinal` → delta vs `pointage_frappeurs`. Premier appel → delta = nouvelles valeurs. |
| Bucket Storage temple | `https://xgyskiatppgaeaamjhxr.supabase.co/storage/v1/object/public/temple/` |
| Avatar temple | Data URI SVG encodée `%22` pour les guillemets — pas de `'` dans la chaîne JS |
| `saison` type | `frappeurs_saison.saison` = TEXT. `matchs_regulier.saison` = INTEGER. Cast : `mr.saison::text = '2026'` |
| Auth admin pages | Session dans `localStorage['lbma_admin_session']` — `{user, nom, role, equipe, expires, remember}` |
| `benchage.html` | Lit `localStorage['lbma_admin_session']`. Accès : coach/admin/superadmin. Sources : `pointage_frappeurs` + `matchs_regulier` (final) + `matchs_series`. Saison auto via `saison_info`. |
| Tri stats frappeurs | MOY desc → CS desc → AB desc → NOM asc — identique sur `stats-frappeurs`, `stats-live`, `archives-frappeurs` |
| Highlights leaders | Fonction `h(val, max)` dans `stats-frappeurs` ; même logique dans les deux autres. Toutes colonnes sauf PJ. |
| `stats-match.html` | Page publique. Paramètre `?id=X`. Sources : `matchs_regulier` + `pointage_frappeurs` + `pointage_lanceurs` (ordre.asc). Lanceur idx=0 → V/D/N ; releveurs → tirets. PM = colonne `er`. |
| `admin_users` (sécurité) | Policy `service_role_only_admin_users` depuis le 15 mai 2026. Accès via RPCs : `list_admin_users()`, `delete_admin_user(p_id)`, `save_user(...)`, `login_user(...)`, `change_password(...)`. Aucun accès direct via clé anon. |
| Supabase Data API (oct 2026) | Nouvelles tables `public` nécessitent `GRANT` explicites à partir du 30 oct 2026. Tables existantes non affectées. Template : `LBMA-template-nouvelle-table.sql`. Audit : `LBMA-audit-grants.sql`. |

---

## 10. PROCÉDURE FIN DE SAISON 2026

### Étape 1 — Mise à jour carrières frappeurs
Exécuter **`Fin saison 2026 - MAJ carrières frappeurs`** dans Supabase SQL Editor.

### Étape 2 — Mise à jour carrières lanceurs
Exécuter **`Fin saison 2026 - MAJ carrières lanceurs`** dans Supabase SQL Editor.

### Étape 3 — Changer de saison
```sql
UPDATE saison_info SET valeur = '2027' WHERE cle = 'saison_active';
```

### Étape 4 — Sauvegarde
GitHub ZIP + export CSV tables priorité 1

---

## 11. PROCÉDURE SAUVEGARDE

### GitHub
`github.com/schausse-hash/lbma` → Code → Download ZIP

### Supabase — backup-supabase.html
Tables priorité 1 à exporter en CSV :
- `frappeurs_saison`, `lanceurs_saison`, `joueurs_liste`, `equipes_saison`
- `matchs_regulier`, `matchs_series`, `birthday_emails_sent`
- `saison_info`, `alertes`

---

## 12. SQL UTILES — SAISON 2026

### Reconstruire frappeurs_saison depuis pointage_frappeurs
```sql
UPDATE frappeurs_saison fs
SET pj=subq.games, ab=subq.ab, cs=subq.cs,
    simples=subq.b1, doubles=subq.b2, triples=subq.b3,
    cc=subq.cc, pc=subq.r, pp=subq.rbi,
    bb=subq.bb, sac=subq.sac, rb=subq.k,
    moy=CASE WHEN subq.ab>0 THEN ROUND(subq.cs::numeric/subq.ab,3) ELSE 0 END
FROM (
    SELECT pf.joueur, pf.equipe,
        COUNT(DISTINCT CASE WHEN (pf.ab+COALESCE(pf.bb,0)+COALESCE(pf.sac,0))>0 THEN pf.match_id END) AS games,
        SUM(pf.ab) AS ab, SUM(pf.h) AS cs,
        SUM(COALESCE(pf.b1,0)) AS b1, SUM(COALESCE(pf.b2,0)) AS b2,
        SUM(COALESCE(pf.b3,0)) AS b3, SUM(COALESCE(pf.cc,0)) AS cc,
        SUM(pf.r) AS r, SUM(pf.rbi) AS rbi,
        SUM(COALESCE(pf.bb,0)) AS bb, SUM(COALESCE(pf.sac,0)) AS sac,
        SUM(COALESCE(pf.k,0)) AS k
    FROM pointage_frappeurs pf
    INNER JOIN matchs_regulier mr ON mr.id=pf.match_id
    WHERE mr.saison::text='2026' AND mr.status='final'
    GROUP BY pf.joueur, pf.equipe
) subq
WHERE fs.saison='2026' AND fs.nom=subq.joueur AND fs.equipe=subq.equipe;
```

### Ajouter joueurs manquants dans frappeurs_saison
```sql
INSERT INTO frappeurs_saison (saison,nom,equipe,pj,ab,cs,simples,doubles,triples,cc,pc,pp,bb,sac,rb,moy)
SELECT '2026',es.joueur_nom,es.equipe,0,0,0,0,0,0,0,0,0,0,0,0,0
FROM equipes_saison es
WHERE es.saison='2026' AND es.equipe NOT IN ('AUTRE')
  AND NOT EXISTS (
    SELECT 1 FROM frappeurs_saison fs
    WHERE fs.saison='2026' AND fs.nom=es.joueur_nom AND fs.equipe=es.equipe
  );
```

### Vérifier les benchages de la saison en cours
```sql
SELECT pf.joueur, es.equipe,
    COUNT(CASE WHEN pf.off = true THEN 1 END) AS nb_off,
    COUNT(CASE WHEN pf.def = true THEN 1 END) AS nb_def,
    COUNT(CASE WHEN pf.off = true OR pf.def = true THEN 1 END) AS nb_bench
FROM equipes_saison es
LEFT JOIN pointage_frappeurs pf ON pf.joueur = es.joueur_nom AND pf.equipe = es.equipe
LEFT JOIN matchs_regulier mr ON mr.id = pf.match_id AND mr.status = 'final'
WHERE es.saison = '2026' AND es.equipe NOT IN ('AUTRE')
GROUP BY pf.joueur, es.equipe
ORDER BY es.equipe, nb_bench DESC;
```
