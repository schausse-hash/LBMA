/* =====================================================================
   LBMA — Navigation partagée (source unique de vérité)
   VARIANTE A « Appli de match » — branche test ui-test-a-appli
   ---------------------------------------------------------------------
   Ordi : barre du haut avec les 5 pages les plus visitées + « Plus ».
   Cellulaire : barre d'onglets en bas de l'écran (comme une appli),
   et « Plus » ouvre un panneau avec tout le reste, regroupé.
   Pour modifier le menu du site entier : éditer CE fichier seulement.
   ===================================================================== */
(function () {
  'use strict';

  /* Les 5 destinations principales (80 % des visites) */
  var PRINCIPAL = [
    { label: 'Accueil',      href: 'index.html',              icone: 'maison' },
    { label: 'Calendrier',   href: 'calendrier.html',         icone: 'calendrier' },
    { label: 'Classement',   href: 'classement-equipes.html?vue=saison', icone: 'podium' },
    { label: 'Stats',        long: 'Statistiques', href: 'stats-frappeurs.html', icone: 'stats',
      aussi: ['stats-lanceurs.html', 'stats-series.html'] },
    { label: 'Équipes',      href: 'equipes.html',            icone: 'equipes', ordiSeulement: true }
  ];

  /* Tout le reste, regroupé par intention */
  var GROUPES = [
    { titre: 'Saison en cours', liens: [
      { label: 'Équipes', href: 'equipes.html' },
      { label: 'Joueurs', href: 'joueurs.html' },
      { label: 'Cartes de joueurs', href: 'carte-joueurs.html' },
      { label: 'Stats des frappeurs', href: 'stats-frappeurs.html' },
      { label: 'Stats des lanceurs', href: 'stats-lanceurs.html' },
      { label: 'Séries éliminatoires', href: 'stats-series.html' },
      { label: 'Terrains', href: 'terrains.html' },
      { label: 'Règlements', href: 'reglements.html' }
    ]},
    { titre: 'Histoire depuis 1976', liens: [
      { label: 'Saisons et champions', href: 'archives-saisons.html' },
      { label: 'Classements historiques', href: 'classement-equipes.html' },
      { label: 'Frappeurs par année', href: 'archives-frappeurs.html' },
      { label: 'Lanceurs par année', href: 'archives-lanceurs.html' },
      { label: 'Carrières des frappeurs', href: 'frappeurs-carriere.html' },
      { label: 'Carrières des lanceurs', href: 'lanceurs-carriere.html' },
      { label: 'Records des frappeurs', href: 'frappeurs-records.html' },
      { label: 'Records des lanceurs', href: 'lanceurs-records.html' },
      { label: 'Temple de la renommée', href: 'temple-renommee.html' },
      { label: 'Toutes les archives', href: 'archives.html' }
    ]},
    { titre: 'La ligue', liens: [
      { label: 'Direction', href: 'contact.html' },
      { label: 'Nous joindre', href: 'nous-contacter.html' },
      { label: 'Médias', href: 'revue-presse.html' },
      { label: 'Liens utiles', href: 'liens-utiles.html' }
    ]}
  ];

  var ICONES = {
    maison: '<path d="M3 11.5 12 4l9 7.5"/><path d="M5.5 10v9.5h5v-5h3v5h5V10"/>',
    calendrier: '<rect x="3.5" y="5" width="17" height="15" rx="2.5"/><path d="M3.5 9.5h17M8 3v4M16 3v4"/>',
    podium: '<path d="M9 20V9h6v11M3 20v-6h6M15 20v-8h6v8M2 20h20"/>',
    stats: '<path d="M4 20V10M10 20V4M16 20v-7M22 20H2"/>',
    equipes: '<circle cx="9" cy="8" r="3.2"/><path d="M3 19c.6-3.3 3-5 6-5s5.4 1.7 6 5"/><circle cx="17" cy="9" r="2.4"/><path d="M16 14c2.6 0 4.4 1.4 5 4"/>',
    plus: '<circle cx="5" cy="12" r="1.6"/><circle cx="12" cy="12" r="1.6"/><circle cx="19" cy="12" r="1.6"/>'
  };
  function icone(n) {
    return '<svg class="ln-ico" viewBox="0 0 24 24" aria-hidden="true" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">' + ICONES[n] + '</svg>';
  }

  var courante = (location.pathname.split('/').pop() || 'index.html').toLowerCase() || 'index.html';
  var vue = (new URLSearchParams(location.search).get('vue') || '');
  function page(h) { return h.split('?')[0]; }
  function actif(item) {
    // classement-equipes.html sert deux vues : ?vue=saison (onglet Classement) et l'historique
    if (page(item.href) === courante && item.href.indexOf('vue=') !== -1) return vue === 'saison';
    if (item.href === courante && courante === 'classement-equipes.html' && vue === 'saison') return false;
    return item.href === courante || (item.aussi || []).indexOf(courante) !== -1;
  }
  var dansPlus = !PRINCIPAL.some(actif);

  function lienPrincipal(item, cls) {
    var a = actif(item);
    return '<a class="' + cls + (item.ordiSeulement ? ' ln-ordi' : '') + '" href="' + item.href + '"' + (a ? ' aria-current="page"' : '') + '>' +
      (cls === 'ln-tab' ? icone(item.icone) : '') + '<span>' + (cls === 'ln-tab' ? item.label : (item.long || item.label)) + '</span></a>';
  }

  function panneau() {
    return GROUPES.map(function (g) {
      return '<section class="ln-groupe"><h2>' + g.titre + '</h2>' + g.liens.map(function (l) {
        return '<a href="' + l.href + '"' + (actif(l) ? ' aria-current="page"' : '') + '>' + l.label + '</a>';
      }).join('') + '</section>';
    }).join('') + '<a class="ln-admin" href="admin.html">Accès des administrateurs et marqueurs</a>';
  }

  function construire() {
    return '' +
      '<div class="ln-barre">' +
        '<a href="index.html" class="ln-logo" aria-label="LBMA, accueil"><img src="logo-lbma.jpg" alt=""><span>LBMA</span></a>' +
        '<div class="ln-liens">' + PRINCIPAL.map(function (i) { return lienPrincipal(i, 'ln-lien'); }).join('') +
          '<button type="button" class="ln-lien ln-plus-btn" aria-expanded="false" aria-controls="ln-panneau"' + (dansPlus ? ' data-actif' : '') + '><span>Plus</span></button>' +
        '</div>' +
      '</div>' +
      '<div class="ln-voile" hidden></div>' +
      '<div class="ln-panneau" id="ln-panneau" hidden><div class="ln-panneau-int">' +
        '<div class="ln-panneau-tete"><strong>Tout le site</strong><button type="button" class="ln-fermer" aria-label="Fermer">✕</button></div>' +
        '<div class="ln-groupes">' + panneau() + '</div>' +
      '</div></div>' +
      '<div class="ln-tabs" role="navigation" aria-label="Navigation principale">' +
        PRINCIPAL.filter(function (i) { return !i.ordiSeulement; }).map(function (i) { return lienPrincipal(i, 'ln-tab'); }).join('') +
        '<button type="button" class="ln-tab ln-plus-btn" aria-expanded="false" aria-controls="ln-panneau"' + (dansPlus ? ' data-actif' : '') + '>' + icone('plus') + '<span>Plus</span></button>' +
      '</div>';
  }

  function brancher(root) {
    var pan = root.querySelector('.ln-panneau'), voile = root.querySelector('.ln-voile');
    var boutons = root.querySelectorAll('.ln-plus-btn');
    function ouvrir(o) {
      pan.hidden = !o; voile.hidden = !o;
      document.documentElement.classList.toggle('ln-ouvert', o);
      boutons.forEach(function (b) { b.setAttribute('aria-expanded', o ? 'true' : 'false'); });
      if (o) { var f = pan.querySelector('a'); if (f) f.focus({ preventScroll: true }); }
    }
    boutons.forEach(function (b) { b.addEventListener('click', function () { ouvrir(pan.hidden); }); });
    voile.addEventListener('click', function () { ouvrir(false); });
    root.querySelector('.ln-fermer').addEventListener('click', function () { ouvrir(false); });
    document.addEventListener('keydown', function (e) { if (e.key === 'Escape' && !pan.hidden) ouvrir(false); });
  }

  function render() {
    var root = document.getElementById('lbma-nav-root');
    if (!root) return;
    root.classList.add('ln');
    document.documentElement.classList.add('lbma-theme');
    root.innerHTML = construire();
    brancher(root);
  }

  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', render);
  else render();

  /* ---- Cellulaire : équipes en 2 lettres dans les tableaux de stats ----
     « HARFANGS » devient « HA », et l'en-tête « Équipe » devient « ÉQ ».
     Le texte d'origine est gardé : il revient si l'écran redevient large. */
  var ABREGE = { AIGLES: 'AI', CONDORS: 'CO', DUCS: 'DU', FAUCONS: 'FA', HARFANGS: 'HA', VAUTOURS: 'VA' };
  var etroit = window.matchMedia('(max-width: 820px)');
  function abreger() {
    var court = etroit.matches;
    document.querySelectorAll('.stats-table th[data-col="equipe"], .stats-table td.team-col').forEach(function (c) {
      if (c.dataset.lbmaLong === undefined) {
        var t = c.textContent.trim();
        var etoile = /\*\s*$/.test(t);                 // « HARFANGS * » : réserviste ou échange
        var cle = t.replace(/\s*\*\s*$/, '').toUpperCase();
        var abr = c.tagName === 'TH' ? (/^ÉQ(UIPE)?$/i.test(t) ? 'ÉQ' : null) : (ABREGE[cle] ? ABREGE[cle] + (etoile ? '*' : '') : null);
        if (!abr) return;
        c.dataset.lbmaLong = t; c.dataset.lbmaCourt = abr;
        if (c.tagName === 'TD') c.title = t.charAt(0) + t.slice(1).toLowerCase();
      }
      var voulu = court ? c.dataset.lbmaCourt : c.dataset.lbmaLong;
      if (c.textContent !== voulu) c.textContent = voulu;
    });
    /* Titres de groupe (« Lanceurs partants ») : le texte est mis dans un
       <span> qui reste fixe pendant qu'on glisse les colonnes de chiffres. */
    document.querySelectorAll('.stats-table tr.section-header > td').forEach(function (td) {
      if (td.querySelector('.lbma-collant')) return;
      var sp = document.createElement('span');
      sp.className = 'lbma-collant';
      while (td.firstChild) sp.appendChild(td.firstChild);
      td.appendChild(sp);
    });
  }
  var attente = null;
  function planifier() { if (attente) return; attente = requestAnimationFrame(function () { attente = null; abreger(); }); }
  function demarrer() {
    if (!document.querySelector('.stats-table')) return;
    abreger();
    new MutationObserver(planifier).observe(document.body, { childList: true, subtree: true });
    if (etroit.addEventListener) etroit.addEventListener('change', abreger);
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', demarrer);
  else demarrer();
})();
