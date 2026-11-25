# CLAUDE.md — règles du dépôt LBMA

À lire au début de chaque session. **Réponds toujours en français** (Sergio, le commissaire, ne lit pas l'anglais). Phrases courtes.

Le détail de l'architecture et du modèle de données est dans `docs/LBMA-REFERENCE.md`. La façon de modifier le site est dans `docs/WORKFLOW-SERGIO.md`. Les rosters et les cartes : `docs/MODELE-roster-cartes.md`. Ce fichier-ci ne recopie pas tout : il donne les règles à ne jamais oublier.

---

## Le site et où il vit

- **www.liguelbma.org** : site de la LBMA, ligue de balle-molle récréative (6 équipes, 75 matchs de saison régulière, puis les séries). Stats historiques depuis 1976.
- HTML, CSS et JavaScript simples, **sans compilation**. Pas de framework à ajouter sans l'accord de Sergio.
- **Dépôt** : `schausse-hash/LBMA` (public). `main` = production.
- **Vercel** publie `main` en 1 à 2 minutes après une fusion, et crée un aperçu pour chaque PR. Les clés secrètes (Resend, Twilio, Supabase service_role) vivent dans les variables d'environnement Vercel, jamais dans le code.
- **Supabase** : projet `xgyskiatppgaeaamjhxr` (us-east-2). Accès par `assets/js/sb-client.js`.
- Fonctions serveur dans `api/` (courriels Resend, SMS Twilio).

## Le chemin d'un changement

```
branche → code → node scripts/verifier.mjs → push → PR vers main
→ ✅ « Syntaxe et secrets » + aperçu Vercel → Sergio teste → Sergio fusionne
```

- Toujours partir de `origin/main` à jour. Une tâche = une branche = une PR.
- `main` est **verrouillée** (règle « proteger main ») : jamais de push direct.
- **Jamais de PR avant d'avoir codé.** Code, vérifie, puis ouvre la PR.
- Avant chaque push : `node scripts/verifier.mjs`. C'est la même vérification que GitHub (syntaxe JS, scripts des pages HTML, JSON, clés secrètes). Le bouton Merge reste gris tant qu'elle n'est pas verte.
- Rebase sur `origin/main` avant de pousser ; en cas de conflit, garde les deux intentions.
- Codex relit chaque PR : une remarque orange (P1) se corrige avant la fusion.
- **C'est Sergio qui fusionne**, après avoir testé l'aperçu :
  `lbma-git-<nom-de-la-branche>-serge-chausses-projects.vercel.app`
  Donne-lui ce lien et dis-lui quoi regarder.
- Changement d'interface : captures de l'aperçu avant la PR (ordinateur et cellulaire si la page sert aux deux).

## Une seule base : les aperçus écrivent dans la vraie

- `xgyskiatppgaeaamjhxr` sert le site, **tous les aperçus Vercel** et le travail local. Pas de branche de test.
- Sur un aperçu, on **regarde** : on ne pointe pas un match, on ne supprime rien. Jamais de données de test dans la base.
- SMS, courriels et fiches sont **simulés** sur un aperçu (`VERCEL_ENV` différent de `production`). Ne retire jamais cette protection.
- Jamais d'envoi réel aux joueurs depuis une session ou un test. Les envois de masse excluent les inactifs. Limite LBMA : 70 courriels par jour.

## Règles SQL

- Tout changement de structure ou de données = un fichier `sql/<sujet>-AAAA-MM-JJ.sql` dans la branche, avec en tête ce qu'il fait et comment revenir en arrière.
- **Essai à blanc** d'abord : bloc `DO` terminé par `raise exception`, pour compter les lignes touchées.
- **Sauvegarde** avant toute modification en lot : `create table backup_<nom>_<date> as select …` puis `alter table … enable row level security`.
- **Rien de destructif** (DELETE, DROP, TRUNCATE, suppression d'un joueur, d'un match, d'un compte) sans le « go » explicite de Sergio, avec le nombre de lignes touchées.
- **Nouvelle table** : suivre `docs/template_sql_apres30octobre.txt` (RLS activée, GRANT, politiques explicites).
- Lire la base (SELECT) pour comprendre est permis. Le SQL qui écrit se prépare dans un fichier ; Sergio l'applique.
- `execute_sql` à plusieurs instructions ne renvoie que la dernière : lance les vérifications une à une.
- Plus de 1000 lignes (ex. `frappeurs_saison`) : pagination avec un départage unique (`id.asc`) après le tri principal.
- Rôles : `marqueur` / `coach`, `admin`, `superadmin` ; session dans `lbma_admin_session`. Respecte la matrice de `sql/securite-phase-e2-roles.sql`.

## Règles d'or du modèle de données

Détail : section 3 et 9 de `docs/LBMA-REFERENCE.md`.

1. **Reporter un match** : modifier le match existant (date, statut, note). Jamais en ajouter un. `no_match` ne change jamais.
2. **Un match se pointe avec `stats-live.html` ou `pointage.html`, jamais les deux.** Les séries se pointent avec `stats-series-live.html` ; `matchs_series` est la cédule des séries (`series_matches` est obsolète). Refinaliser un match de série compte ses stats deux fois.
3. **Statut d'un joueur** : activer ou désactiver seulement par « Joueurs Repêchage » (`joueurs_liste.actif`). « Joueurs (Liste) » et « Joueurs Repêchage » sont deux vues de la même table.
4. **Rosters** : `repechage_picks` = historique figé du repêchage ; `equipes_saison` = roster vivant, **source de vérité** de l'équipe d'un joueur. Remplacer un joueur : bouton 🔄 d'Équipes Saison. Jamais supprimer le sortant.
5. **Un champ = une seule signification** (ne pas réutiliser `role` pour un statut comme « blessé »).
6. **Navigation** : modifier `assets/js/lbma-nav.js` seulement.
7. **Poste sur une carte** : `car_pl`, jamais `position`.
8. **Photos d'équipe** : `EQUIPE_ANNEE.jpg`, jamais écrasées.
9. **Année** : jamais `'2027'` ni `new Date().getFullYear()` dans une page. Inclure `assets/js/lbma-saison.js` et utiliser `window.LBMA_SAISON` (lu de `saison_info.saison_active`).
10. **Types** : `frappeurs_saison.saison` est TEXT ; `matchs_regulier.saison` est INTEGER.

## Conventions de noms

Les stats se rattachent à un joueur **par son nom**. Une variante (accent, apostrophe, ordre, trait d'union) crée un **joueur fantôme** dont les stats se coupent en deux.

- Format standard : `NOM PRÉNOM` en **majuscules**, accents compris, **sans apostrophe**, identique partout. Ex. `TREMPE BILODEAU SACHA`, `OREILLY MYLES`, `BELLIVEAU ÉRIC`.
- Exceptions : `joueurs_equipe` = `Nom, Prénom` ; `frappeurs_series` = `Prénom Nom`.
- Vérifie la bonne équipe avant d'agir : un même nom de famille peut exister dans plusieurs équipes.

## Pièges d'édition

- Les gros fichiers HTML (souvent en CRLF) peuvent être **tronqués** à l'édition. Après chaque modification, vérifie que le fichier finit par `</html>` et compare sa taille avec `git show HEAD:<fichier>`.
- Certains gros fichiers s'affichent coupés à la lecture alors qu'ils sont intacts : compare le nombre d'octets avant de conclure.
- **Jamais `git add .` ni `git add -A`** : toujours `git add <fichier>` précis.
- Les pages d'admin servent au cellulaire et à la tablette (pointage au terrain) : vérifie l'affichage étroit.
- Fichiers partagés (une seule tâche à la fois y touche) : `assets/js/lbma-nav.js`, `assets/js/lbma-utils.js`, `assets/js/lbma-saison.js`, `assets/js/sb-client.js`, `admin.html`, `docs/LBMA-REFERENCE.md`, `CLAUDE.md`.

## Le dépôt est public

- **Rien de personnel** : ni nom avec téléphone, ni courriel, ni adresse de joueur. Les fichiers de contacts restent hors du dépôt (`.gitignore`).
- **Aucun secret** : ni clé, ni jeton, ni mot de passe, ni détail de compte. `scripts/verifier.mjs` bloque les clés connues, mais ne compte pas que sur lui.
- Rien qui aide à contourner la sécurité du site.

## Ce qui reste à Sergio

La fusion des PR, les variables d'environnement Vercel, toute opération destructive, les envois réels aux joueurs, les comptes fournisseurs et les paiements.
