# 🚀 Workflow Sergio — Sessions Claude

*Créé le 15 mai 2026 — dernière mise à jour : 15 mai 2026 (après-midi)*

---

## Avant chaque session — 3 étapes

### 1. Synchroniser le projet sur lequel tu vas travailler

Ouvre PowerShell ou VS Code, va dans le dossier du projet, fais un `git pull` :

```powershell
cd C:\Users\schau\documents\applicationsweb\lbma
git pull origin main
```

Remplace `lbma` par `dr-chausse-website` ou `facehub` selon le projet.

### 2. Démarrer la conversation Claude

Dis-moi clairement sur quel projet on travaille. Par exemple :

> « On travaille sur FaceHub aujourd'hui, dossier à jour. »

### 3. Vérifier que Supabase est connecté

Le connecteur Supabase reste actif d'une session à l'autre. Si jamais Claude ne voit pas tes projets, reclique « Connect » dans les paramètres MCP.

---

## Pendant la session

Claude peut faire **directement** :

- Lire et modifier tes fichiers HTML / JS / React / CSS
- Exécuter du SQL sur tes 3 projets Supabase
- Chercher dans ton code (« où est utilisée telle fonction ? »)
- Auditer les policies, GRANTs, RLS

Tu n'as plus besoin de copier-coller. Tu valides juste les changements importants.

---

## Après la session

### 1. Vérifier les changements

```powershell
git status        # voir les fichiers modifiés
git diff          # voir le détail des changements
```

### 2. Pousser sur GitHub

```powershell
git add .
git commit -m "Description du changement"
git push origin main
```

### 3. Vérifier le déploiement Vercel

Automatique en 1-2 min après le push. Vérifier dans le dashboard Vercel que la build est verte.

---

## 📁 Tes 3 projets

| Projet | Dossier local | Supabase ID | URL production |
|---|---|---|---|
| **LBMA** | `C:\Users\schau\documents\applicationsweb\lbma` | `xgyskiatppgaeaamjhxr` | www.liguelbma.org |
| **Dentiste.com** | `C:\Users\schau\documents\applicationsweb\dr-chausse-website` | `bjxplcepfhwnwiuyovxw` | www.dentiste.com |
| **FaceHub** | `C:\Users\schau\documents\applicationsweb\facehub` | `pmgbwtngjjnjwhmjxeuc` | www.facehub.ca |

---

## ⚠️ Points d'attention

- **Claude n'a pas de mémoire entre sessions** → partage-lui toujours ton résumé de projet en début de session
- **Pour les changements risqués** : on fait toujours un backup avant + on peut rollback via Vercel
- **Aucune opération destructive** (DROP, DELETE, etc.) sans confirmation explicite de ta part

---

## 🎯 Prochaines sessions possibles

### Court terme — pas de travail urgent
Les 3 projets sont maintenant sécurisés. Pas de chantier obligatoire avant le 30 octobre 2026.

### À planifier

| Projet | Sujet | Quand |
|---|---|---|
| **LBMA** | Items « Haute priorité » du résumé (séries 2024, sauvegardes) | Quand tu auras le temps |
| **Dentiste.com** | Fix `app/services/[slug]/page.js` JSON.parse + page désabonnement | Urgent selon ton résumé |
| **FaceHub** | Sprint 3 — inviter Emilie, Theresa, Dr Youssef (RLS prêt) | Au choix |

### Avant le 30 octobre 2026

- Toute nouvelle table Supabase doit utiliser le template `LBMA-template-nouvelle-table.sql` (créé aujourd'hui)
- Cette date est l'échéance où Supabase verrouille les nouvelles tables par défaut

---

## 📚 Documentation sécurité créée le 15 mai 2026

### Sur LBMA (`lbma/sql/`)
- `dump-securite-15mai2026.sql` — 1628 lignes, 5 RPCs + 182 policies + 39 tables

### Sur Dentiste.com (`dr-chausse-website/sql/`)
- `dump-securite-15mai2026.sql` — dump complet idempotent
- `rollback-policies-15mai2026.sql` — rollback si besoin
- `SECURITE-15mai2026.md` — documentation détaillée

### Sur FaceHub (`facehub/sql/`)
- `dump-securite-15mai2026.sql` — 701 lignes, 2 fonctions SECURITY DEFINER + 57 policies
- `rollback-policies-15mai2026.sql` — rollback si besoin
- `SECURITE-15mai2026.md` — documentation détaillée

### Fichiers utilitaires (peuvent être copiés entre projets)
- `LBMA-audit-grants.sql` — Audit complet des policies/GRANTs
- `LBMA-template-nouvelle-table.sql` — Template pour nouvelles tables post-oct 2026
- `LBMA-supabase-data-api-2026.md` — Documentation du changement Supabase

---

## 🔐 État de sécurité au 15 mai 2026

| Projet | Architecture | Statut |
|---|---|---|
| **LBMA** | Auth client-side + admin_users via RPCs SECURITY DEFINER | ✅ Sécurisé |
| **Dentiste.com** | Supabase Auth + `is_admin()`/`is_editor_or_admin()` | ✅ Sécurisé + Loi 25 |
| **FaceHub** | Supabase Auth + RLS hiérarchique par clinique | ✅ Sécurisé + multi-tenant |

**Triple backup partout** : GitHub + Supabase live + dump SQL local.
