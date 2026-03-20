// ============================================================
// lbma-utils.js — Utilitaires partagés LBMA
// Créé : 3 mars 2026
// Usage : <script src="/assets/js/lbma-utils.js"></script>
// ============================================================

// ------------------------------------------------------------
// ÉQUIPES — Couleurs officielles
// ------------------------------------------------------------
const LBMA_COULEURS = {
    AIGLES:   '#FF8C00',
    CONDORS:  '#124FB2',
    DUCS:     '#006400',
    FAUCONS:  '#CC0000',
    HARFANGS: '#929292',
    VAUTOURS: '#333366'
};

// ------------------------------------------------------------
// ÉQUIPES — Abréviations (NOM_COMPLET → abrégé)
// ------------------------------------------------------------
const LBMA_ABBREV = {
    AIGLES:   'AI',
    CONDORS:  'CO',
    DUCS:     'DU',
    FAUCONS:  'FA',
    HARFANGS: 'HA',
    VAUTOURS: 'VA'
};

// ------------------------------------------------------------
// ÉQUIPES — Noms complets (abrégé → NOM_COMPLET)
// ------------------------------------------------------------
const LBMA_NOMS = {
    AI: 'Aigles',
    CO: 'Condors',
    DU: 'Ducs',
    FA: 'Faucons',
    HA: 'Harfangs',
    VA: 'Vautours'
};

// Liste ordonnée des équipes
const LBMA_EQUIPES = ['AIGLES', 'CONDORS', 'DUCS', 'FAUCONS', 'HARFANGS', 'VAUTOURS'];

// ------------------------------------------------------------
// CONFIGURATION DE LA LIGUE
// ------------------------------------------------------------
const LBMA_CONFIG = {
    MAX_JOUEURS_PAR_EQUIPE: 11,   // ← changer ici si la ligue change
    NB_EQUIPES: 6
};
// NB_RONDES calculé automatiquement : MAX - 1 coach - 1 ronde 0
LBMA_CONFIG.NB_RONDES = LBMA_CONFIG.MAX_JOUEURS_PAR_EQUIPE - 2;

// ------------------------------------------------------------
// FONCTIONS UTILITAIRES
// ------------------------------------------------------------

/**
 * Retire les accents d'une chaîne.
 * Ex: "Bélair" → "Belair"
 */
function removeAccents(str) {
    return (str || '').normalize('NFD').replace(/[\u0300-\u036f]/g, '');
}

/**
 * Normalise un nom de joueur pour comparaison :
 * accents retirés, majuscules, espaces normalisés.
 * Ex: "bélair, mario" → "BELAIR, MARIO"
 */
function normalizeName(nom) {
    return removeAccents((nom || '').toUpperCase())
        .replace(/,\s*/g, ', ')
        .replace(/\s+/g, ' ')
        .trim();
}

/**
 * Clé de matching pour regrouper les joueurs par nom.
 * Même logique que normalizeName — utilisé dans les carrières.
 */
function nameKey(nom) {
    if (!nom) return '';
    return nom.trim().toUpperCase()
        .normalize('NFD')
        .replace(/[\u0300-\u036f]/g, '')
        .replace(/,\s*/g, ', ')
        .replace(/\s+/g, ' ');
}

/**
 * Retourne la couleur officielle d'une équipe.
 * Accepte le nom complet en majuscules.
 * Ex: getEquipeCouleur('AIGLES') → '#FF8C00'
 * Ex: getEquipeCouleur('Faucons') → '#CC0000'
 */
function getEquipeCouleur(nom) {
    if (!nom) return '#999999';
    return LBMA_COULEURS[(nom || '').toUpperCase()] || '#999999';
}

/**
 * Retourne l'abréviation d'une équipe.
 * Ex: getEquipeAbbrev('CONDORS') → 'CO'
 */
function getEquipeAbbrev(nom) {
    if (!nom) return '';
    return LBMA_ABBREV[(nom || '').toUpperCase()] || nom;
}

/**
 * Retourne le nom complet d'une équipe depuis son abréviation.
 * Ex: getEquipeNom('FA') → 'Faucons'
 */
function getEquipeNom(abbrev) {
    if (!abbrev) return '';
    return LBMA_NOMS[(abbrev || '').toUpperCase()] || abbrev;
}

// ------------------------------------------------------------
// EXPORT — rendre accessible globalement
// ------------------------------------------------------------
window.LBMA_COULEURS   = LBMA_COULEURS;
window.LBMA_ABBREV     = LBMA_ABBREV;
window.LBMA_NOMS       = LBMA_NOMS;
window.LBMA_EQUIPES    = LBMA_EQUIPES;
window.LBMA_CONFIG     = LBMA_CONFIG;
window.removeAccents   = removeAccents;
window.normalizeName   = normalizeName;
window.nameKey         = nameKey;
window.getEquipeCouleur = getEquipeCouleur;
window.getEquipeAbbrev  = getEquipeAbbrev;
window.getEquipeNom     = getEquipeNom;
