# LBMA — Résumé de session
**Date :** 31 mai 2026  
**Projet :** liguelbma.org (`schausse-hash/LBMA`)  
**Supabase :** `xgyskiatppgaeaamjhxr`  
**GitHub token :** `github_pat_*** (voir 1Password)`

---

## Vue d'ensemble

Deux chantiers :

1. **Envois de masse respectent le statut « actif »** — finalisation de la décision reportée le 30 mai sur le statut « blessé/parti ». Les joueurs désactivés ne reçoivent plus ni courriel, ni SMS, ni fiche personnalisée.
2. **Nouvelle page Terrains** — page statique avec vues satellite Google Maps (12 parcs), aux couleurs LBMA, plus configuration complète de Google Maps Platform (clé API).

---

## Fichiers modifiés

| Fichier | Modifications |
|---|---|
| `api/send-sms.js` | Filtre `actif` ajouté à la requête `joueurs_liste` |
| `admin.html` | Courriel de masse + fiche perso : exclusion des joueurs inactifs |
| `terrains.html` | **Nouveau** — page Terrains (12 parcs, vues satellite, liens Google Maps) |
| 23 pages publiques | Lien « Terrains » ajouté au menu du haut (après Calendrier) |
| 21 pages publiques | Lien « 📍 Terrains » ajouté au pied de page (colonne « La Ligue ») |

---

## 1. Statut « actif » et envois de masse

### Constat de départ
Les joueurs blessés ou partis (ex. Edgar Garcia, Myles O'Reilly, remplacés dans les Harfangs)
continuaient de recevoir les courriels/SMS de masse, même après avoir été désactivés.

### Clarification d'architecture (important)
- **« Joueurs (Liste) »** et **« Joueurs Repêchage »** sont **deux vues de la même table `joueurs_liste`**.
  Ajouter un joueur dans l'une l'ajoute automatiquement dans l'autre — ce n'est pas un bug.
- La colonne **`joueurs_liste.actif`** (booléen, défaut `true`) existait déjà.
- Le **bouton actif/inactif vit uniquement dans « Joueurs Repêchage »** (champ `jrEditActif`),
  pas dans le formulaire de « Joueurs (Liste) ». **Décision : pas de doublon** — on active/désactive
  un joueur depuis Joueurs Repêchage seulement.

### Ce que `actif` pilote désormais
| Usage | Comportement |
|---|---|
| Repêchage (`repechage-live.html`, `repechage-admin.html`) | Bassin draftable = `actif=eq.true` |
| Promotion saison suivante (`admin.html` « Copier vers nouvelle saison ») | Copie uniquement les actifs |
| Dropdowns roster (Équipes Saison) | Affiche uniquement les actifs |
| **Envois de masse (NOUVEAU)** | Courriel + SMS + fiche excluent les inactifs |

> **Effet de bord à retenir** : désactiver un joueur le retire aussi du repêchage **et** de la
> promotion automatique vers la saison suivante. Pour un joueur « parti », c'est voulu. Pour un
> « blessé qui revient », il faut le **réactiver avant la promotion** de la prochaine saison.

### Corrections de code
| Endroit | Avant | Après |
|---|---|---|
| `api/send-sms.js` (ligne ~31) | `...?saison=eq.${saison}&telephone1=not.is.null` | ajout de `&or=(actif.eq.true,actif.is.null)` |
| `admin.html` — courriel de masse | aucun filtre, total = tous les joueurs | `joueurs = joueurs.filter(j => j.actif !== false)` avant le décompte (totaux cohérents) |
| `admin.html` — fiche perso (`ficheChargerJoueurs`) | filtre rôle + courriel seulement | ajout de `j.actif !== false` au filtre |

### Résultat
- **Joueurs (Liste)** : 68 (registre complet, actifs + inactifs — c'est voulu, source de vérité)
- **Joueurs Repêchage** : 66 (actifs seulement)
- **Envoi de masse** : 64 destinataires (actifs avec courriel) — Garcia et O'Reilly retirés

---

## 2. Nouvelle page Terrains

### `terrains.html`
- Page **statique** (pas de base de données), aux couleurs LBMA
  (`--primary` #1E3A5F, `--gold` #D4AF37, bordures noires, polices Bebas/Oswald/Work Sans).
- **12 parcs** triés alphabétiquement, chacun avec : vue satellite, adresse, bouton « Voir sur Google Maps ».
- Entête (nav) + pied de page standard LBMA, `lbma-analytics.js` inclus.

### Liste des 12 terrains
| Parc | Adresse |
|---|---|
| Parc Auteuil | 350 Rue Sauvé Est, Montréal, QC H3L 1H4 |
| Parc Henri-Julien | 9300 Rue Saint-Denis, Montréal, QC H2M 1P1 |
| Parc Ignace-Bourget | 5925 Avenue de Montmagny, Montréal, QC H4E 2V6 |
| Parc Jarry | 205 Rue Gary-Carter, Montréal, QC H2R 2V7 |
| Parc Jean-Martucci | 1207 Rue Étienne-Blanchard, Montréal, QC H2M 2L5 |
| Parc de la Louisiane | 4644 Rue Beaubien, Montréal, QC H1T 1Z5 |
| Parc Marcelin-Wilson | 11301 Boulevard de l'Acadie, Montréal, QC H3M 2T1 |
| Parc Sauvé | 11440 Avenue Éthier, Montréal-Nord, QC H1H 1N9 |
| Parc St-Alphonse | 8888 Avenue De Chateaubriand, Montréal, QC H2M 1X4 |
| Parc St-Claude | 99 7e Rue, Laval, QC H7N 2C6 |
| Parc St-Clément | 1855 Rue de Ville-Marie, Montréal, QC H1V 0B7 |
| Parc Villeray | 8000 Rue de Normanville, Montréal, QC H2R 2V6 |

### Vues satellite (Maps Static API)
- Chaque carte : balise `<img>` vers `maps.googleapis.com/maps/api/staticmap` avec
  `zoom=16`, `size=600x280`, `scale=2`, `maptype=hybrid`, marqueur rouge à l'adresse.
- **`loading="lazy"`** → léger sur iPhone (seules les cartes visibles se chargent).
- **`onerror="this.style.display='none'"`** → si une image échoue, la carte garde texte + bouton.
- Centrage par **adresse civique** ; possibilité d'ajuster un parc précis avec des coordonnées lat/lng au besoin.

### Liens vers la page
- **Menu du haut** : « Terrains » après « Calendrier » (23 pages).
- **Pied de page** : « 📍 Terrains » dans la colonne « La Ligue » (21 pages).

---

## 3. Configuration Google Maps Platform

- **Compte / projet** : Google Cloud « My First Project »
  (ID `project-df9a98c2-4c05-4ab8-b89`), essai gratuit 90 jours / 410 $ de crédit
  (valable jusqu'au ~30 août 2026). Carte de crédit au dossier, **aucune facturation sous le quota gratuit**.
- **API activée** : Maps Static API (tier gratuit ~10 000 appels/mois, puis 2 $/1000).
- **Clé** : « Maps Platform API Key »
  - Valeur : `AIzaSyDXMPTi_XTSGqnCuC__fu2oNsIyyrklu2w` (clé **publique restreinte au domaine**, déjà dans `terrains.html`).
  - Restrictions d'application : référents HTTP `https://www.liguelbma.org/*` et `https://liguelbma.org/*`.
  - Restrictions d'API : 33 API Maps (incl. Maps Static API).
- **Coût réel** : négligeable au trafic LBMA, largement sous le gratuit. Quota journalier plafonnable
  (Quotas → limite quotidienne) pour garantie absolue anti-facture (optionnel).
- **Note** : l'écran de consentement OAuth n'est **pas** requis (on utilise une clé API, pas OAuth).

---

## Commits de la session
| Commit | Objet |
|---|---|
| `f141010` | Envois respectent `actif` (send-sms.js, admin courriel + fiche) |
| `528cb3d` | Courriel de masse : décompte cohérent (filtre actifs) |
| `5d372ea` | Nouvelle page Terrains + lien footer (20 pages) |
| `1b89711` | Footer Terrains sur `lanceurs-carriere.html` (page minifiée) |
| `1cdd31b` | Ajout Parc Jean-Martucci (12e terrain) |
| `db8a216` | Vues satellite Google Maps (Static API, lazy, hybrid + marqueur) |
| `c643703` | Nav « Terrains » dans le menu du haut (23 pages) |

---

## Règles établies (rappel + ajouts)

1. **Reporter un match** → toujours ✏️ Modifier l'existant, JAMAIS Ajouter.
2. **no_match** → ne JAMAIS modifier lors d'un report.
3. **Stats-live vs pointage** → ne JAMAIS mixer les deux outils sur le même match.
4. **Photos équipe** → format `EQUIPE_ANNEE.jpg`, jamais écrasées.
5. **Statut joueur** → on active/désactive UNIQUEMENT via « Joueurs Repêchage » (pas de doublon).
   Désactiver = retiré du repêchage, de la promotion ET des envois. Réactiver un blessé avant la promotion.
6. **Terrains** → page statique éditée à la main (rare). Pour ajouter un parc : dupliquer un bloc
   `<div class="terrain-card">` dans `terrains.html`.

---

## Prochaines étapes suggérées

- [ ] Vérifier le rendu de `terrains.html` sur **www** et **sans-www** (référents).
- [ ] (Optionnel) Plafonner le quota Maps Static API pour la tranquillité d'esprit.
- [ ] (Optionnel) Recentrer un parc mal cadré via coordonnées lat/lng plutôt que l'adresse.
- [ ] (Idée future) Relier l'`endroit` de chaque match du calendrier à sa fiche terrain.

---

*Session réalisée via Claude (claude.ai) — push GitHub direct via API*
