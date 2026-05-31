# Modèle Roster & Cartes de joueurs — LBMA

> Document de référence. Explique **où vit la vérité** pour les équipes/rosters,
> comment remplacer un joueur en cours de saison, et pourquoi le format des noms
> est critique. Dernière mise à jour : mai 2026.

---

## 1. Les deux sources de vérité

Il y a **deux** tables qui parlent d'« équipe », et elles ne servent pas à la même chose.

| Table | Rôle | Modifiable en cours de saison ? |
|---|---|---|
| `repechage_picks` | **Le repêchage réel** : qui a été *repêché* par quelle équipe. C'est un **historique figé**. | ❌ Non — c'est un fait historique. Un remplaçant n'a jamais été repêché. |
| `equipes_saison` | **Le roster vivant** : qui est *réellement* dans l'équipe en ce moment, remplaçants inclus. | ✅ Oui — c'est ce qui change quand un joueur quitte et qu'un autre le remplace. |

**Règle d'or :** un remplacement en cours de saison se fait **uniquement** dans
`equipes_saison`. On ne touche jamais à `repechage_picks` pour ça.

---

## 2. Le bouton 🔄 REMPLACER (Admin → Équipes Saison)

Ce bouton fait **exactement** un `UPDATE equipes_saison SET joueur_nom = …` sur la ligne du
joueur sortant, en **conservant sa position (`ordre`) et sa cote**. Il ne touche qu'à
`equipes_saison`. C'est la façon recommandée de faire un remplacement (plus simple et
plus sûr que du SQL manuel).

---

## 3. D'où les pages lisent l'équipe

Depuis mai 2026, les pages de cartes lisent l'équipe officielle d'un joueur depuis
**`equipes_saison`** (le roster vivant), et **non** depuis `repechage_picks`.

| Page | Liste des joueurs | Équipe officielle |
|---|---|---|
| `carte-joueurs.html` (public) | Union de : joueurs avec stats (`frappeurs_saison`) **+** roster (`equipes_saison`) | `equipes_saison` |
| `admin-cartes.html` (admin) | `joueurs_liste` (tous les joueurs inscrits) | `equipes_saison` |

**Pourquoi l'union sur la page publique ?** Avant, la liste partait uniquement des
stats (`frappeurs_saison`, AB > 0). Un remplaçant qui n'a pas encore frappé n'avait
donc aucune carte. En partant aussi du roster `equipes_saison`, tout joueur réellement
dans une équipe a sa carte — qu'il ait joué ou non (stats 2026 à 0 en attendant).

Les joueurs **sans équipe** (par ex. un joueur sorti du roster) sont automatiquement
exclus de l'affichage des cartes, grâce au filtre `p.equipe && TEAMS[p.equipe]`.

---

## 4. Conventions de noms (CRITIQUE)

La liaison des stats à un joueur se fait **par le nom**. Une faute de frappe = un joueur
fantôme dont les stats ne se rattachent pas. Le format **doit** être exact.

| Table(s) | Format attendu | Exemple |
|---|---|---|
| La plupart (`equipes_saison`, `frappeurs_saison`, `joueurs`, `joueurs_liste`, `pointage_*`, `repechage_picks`…) | `NOM PRÉNOM` en MAJUSCULES | `TREMPE BILODEAU SACHA` |
| `joueurs_equipe` | `Nom, Prénom` | `Trempe Bilodeau, Sacha` |
| `frappeurs_series` | `Prénom Nom` (minuscules) | `Sacha Trempe Bilodeau` |

**Au moment d'ajouter un joueur** (ou un remplaçant), saisir le nom au format exact de
la table concernée. C'est le seul endroit où la procédure peut déraper.

---

## 5. Procédure : remplacer un joueur en cours de saison

1. S'assurer que le remplaçant existe déjà dans `joueurs_liste` pour la saison en cours,
   au format exact `NOM PRÉNOM` (sinon : pas de photo/bio sur la carte, et stats non
   rattachées).
2. Aller dans **Admin → Équipes Saison**, utiliser le bouton 🔄 **REMPLACER** sur le
   joueur sortant.
3. C'est tout. Les cartes (`carte-joueurs.html`, `admin-cartes.html`) et la page équipe
   reflètent le changement automatiquement, car elles lisent `equipes_saison`.
4. Ne **pas** modifier `repechage_picks` : le joueur sortant reste un repêché historique.
   (Optionnel : le marquer `actif = false` dans `joueurs_liste` s'il faut l'exclure des
   envois de masse, sans le supprimer.)

---

## 6. Historique (mai 2026)

- **Cartes découplées du repêchage** : `carte-joueurs.html` et `admin-cartes.html` lisent
  désormais l'équipe depuis `equipes_saison` au lieu de `repechage_picks`. La liste
  publique part de l'union stats + roster.
- **HARFANGS 2026** : `GARCIA EDGAR` et `OREILLY MYLES` (repêchés, partis en cours de
  saison) remplacés dans le roster par `MICHAUD JEAN-DAVID` et `FELX MICHEL`. Le repêchage
  conserve Garcia/O'Reilly. Felx est un vétéran de retour (5 saisons, 1997–2007).
- **Uniformisation Trempe** : consolidation de `Sacha Trempe Bilodeau` (retrait du trait
  d'union et des variantes `TREMPE SASHA`) dans toutes les tables.
