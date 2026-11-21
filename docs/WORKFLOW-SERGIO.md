# 🚀 Workflow Sergio — comment on modifie le site LBMA

*Réécrit le 21 novembre 2026, après la mise en place des PR, de la vérification automatique et du verrou sur `main`.*

---

## Les trois endroits

| Endroit | Rôle | Image |
|---|---|---|
| **GitHub** (`schausse-hash/LBMA`) | Le code et tout son historique. Les branches, les PR, la vérification automatique. | Le classeur des plans |
| **Vercel** | Publie le site (liguelbma.org) à partir de `main`, et crée un **aperçu** pour chaque PR. Garde les clés secrètes (Twilio, Resend, Supabase). | L'entrepreneur qui construit d'après le dernier plan approuvé |
| **Supabase** (`xgyskiatppgaeaamjhxr`) | La base de données : joueurs, stats, calendrier, comptes, coûts. | Ce qu'il y a dans la maison |

Le chemin d'un changement :

```
branche → PR → ✅ vérification + aperçu Vercel → je teste → je fusionne → Vercel publie
```

---

## La règle : `main` est verrouillé

Depuis le 21 novembre 2026, la règle GitHub **« proteger main »** empêche toute modification directe de `main` :

- tout changement passe par une **PR** (0 approbation requise : je fusionne mes propres PR) ;
- le bouton **Merge** reste gris tant que la vérification **« Syntaxe et secrets »** n'est pas ✅ ;
- personne ne peut effacer `main` ni réécrire son historique.

La branche d'une PR fusionnée s'efface toute seule.

---

## Cas 1 — Je travaille avec Claude (le cas habituel)

Claude a sa propre copie du dépôt. Il crée la branche, fait les changements, vérifie, pousse et **ouvre la PR lui-même**.

Moi :

1. J'ouvre la PR sur GitHub (Claude me donne le lien).
2. J'attends ✅ **Syntaxe et secrets**. Codex relit aussi la PR : une remarque **orange (P1)** doit être corrigée avant la fusion ; Claude s'en occupe.
3. Je teste sur l'**aperçu** : `lbma-git-<nom-de-la-branche>-serge-chausses-projects.vercel.app`. Je me reconnecte par `login.html` sur cette adresse si la page demande une connexion.
4. **Merge pull request → Confirm merge.** Vercel publie en 1 à 2 minutes.

Rien à faire sur mon ordinateur.

## Cas 2 — Je modifie un fichier moi-même sur le site GitHub

1. J'ouvre le fichier sur github.com → crayon ✏️ (ou **Add file → Upload files**).
2. En bas, **« Create a new branch for this commit and start a pull request »** (c'est la seule option possible sur `main`).
3. Puis comme au cas 1 : ✅, aperçu, fusion.

## Cas 3 — Je modifie avec VS Code sur mon ordinateur

Copies locales : `C:\Users\schau\dev\lbma` (portable) et `C:\Users\schausse\dev\lbma` (bureau).

```powershell
cd C:\Users\schau\dev\lbma
git checkout main
git pull                              # toujours se mettre à jour d'abord
git checkout -b mon-changement        # nouvelle branche
# … modifier les fichiers …
node scripts/verifier.mjs             # la même vérification que sur GitHub
git add .
git commit -m "Ce que j'ai changé"
git push -u origin mon-changement
```

GitHub affiche alors un bouton **« Compare & pull request »** : je crée la PR, puis comme au cas 1.

`git push` directement sur `main` est refusé : c'est normal, c'est le verrou.

---

## ⚠️ Ce qu'il faut savoir sur les aperçus Vercel

- **SMS, courriels et fiches sont simulés** sur un aperçu : rien ne part chez les joueurs.
- **Mais tout le reste écrit dans la vraie base** : pointage, stats, suppression d'un match, alignements… Sur un aperçu, je **regarde**, je ne supprime rien.
- Pour tester des écritures sans risque, il faudrait une copie de la base (branche Supabase) — pas encore possible : il manque une migration « point de départ ».

---

## Avant de toucher aux données (SQL)

- Claude fait toujours un **essai à blanc** (bloc `DO` terminé par `raise exception`) avant d'appliquer.
- **Sauvegarde avant** toute modification en lot : `create table backup_<nom>_<date> as select …` puis `alter table … enable row level security`.
- **Aucune opération destructive** (DELETE, DROP…) sans mon « go » explicite.
- Retour arrière possible : la sauvegarde, et pour le code, Vercel → Deployments → ancien déploiement → **Promote**.

---

## Une page qui dépend de l'année

Jamais `'2027'` ni `new Date().getFullYear()` dans une page : inclure `assets/js/lbma-saison.js` et utiliser `window.LBMA_SAISON` (lu de `saison_info.saison_active`). Le passage d'une saison à l'autre se fait en changeant **une seule valeur** dans la base.

---

## Mes autres projets (mêmes principes)

| Projet | Dépôt | Supabase | Site |
|---|---|---|---|
| **LBMA** | `schausse-hash/LBMA` | `xgyskiatppgaeaamjhxr` | www.liguelbma.org |
| **Dentiste.com** | `schausse-hash/dr-chausse-website` | `bjxplcepfhwnwiuyovxw` | www.dentiste.com |
| **FaceHub** | `facehub-dentaire/facehub` | `hephntwcjvljprkhtwkv` (Canada) | www.facehub.ca |

---

## Où trouver le reste

- `docs/LBMA-REFERENCE.md` — architecture, conventions, règles du modèle de données.
- `sql/` — scripts de sécurité, schéma, migrations notables (`saison-2027.sql`, `couts-du-site.sql`, `sms-recus.sql`).
- Projet Claude « LBMA+WEB » — documents de reprise (ex. `reprise-saison-2027`).
- Admin → Super Admin → **💰 Coûts du site** — ce que coûte le site, par service.
