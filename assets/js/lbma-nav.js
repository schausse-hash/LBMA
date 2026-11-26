/* =====================================================================
   LBMA — Navigation partagée (source unique de vérité)
   VARIANTE A « Appli de match » — branche test ui-test-a-appli
   ---------------------------------------------------------------------
   Ordi : barre du haut avec les 5 pages les plus visitées + « Plus ».
   Cellulaire : barre d'onglets en bas de l'écran (comme une appli),
   et « Plus » ouvre un panneau de tuiles avec tout le reste, regroupé.
   Le pied de page (allégé) est aussi construit ici, pour toutes les pages.
   Pour modifier le menu du site entier : éditer CE fichier seulement.
   ===================================================================== */
(function () {
  'use strict';

  /* Les 5 destinations principales (80 % des visites) */
  var PRINCIPAL = [
    { label: 'Accueil',      href: 'index.html',              icone: 'maison' },
    { label: 'Calendrier',   href: 'calendrier.html',         icone: 'calendrier' },
    { label: 'Classement',   href: 'stats-classement.html', icone: 'podium' },
    { label: 'Stats',        long: 'Statistiques', href: 'stats-frappeurs.html', icone: 'stats',
      aussi: ['stats-lanceurs.html', 'stats-series.html'] },
    { label: 'Équipes',      href: 'equipes.html',            icone: 'equipes', ordiSeulement: true }
  ];

  /* Tout le reste, dans le panneau « Plus » : des tuiles comme sur un téléphone.
     Les stats des frappeurs n'y sont pas : c'est l'onglet « Stats ». */
  var SAISON = [
    { label: 'Équipes', href: 'equipes.html', icone: 'equipes' },
    { label: 'Joueurs', href: 'joueurs.html', icone: 'joueur' },
    { label: 'Cartes', href: 'carte-joueurs.html', icone: 'carte' },
    { label: 'Lanceurs', href: 'stats-lanceurs.html', icone: 'balle' },
    { label: 'Séries', href: 'stats-series.html', icone: 'trophee' },
    { label: 'Terrains', href: 'terrains.html', icone: 'terrain' },
    { label: 'Règlements', href: 'reglements.html', icone: 'livre' }
  ];
  var HISTOIRE = [
    { label: 'Champions', href: 'archives-saisons.html', icone: 'trophee' },
    { label: 'Classements', href: 'classement-equipes.html', icone: 'podium' },
    { label: 'Temple', href: 'temple-renommee.html', icone: 'temple' },
    { label: 'Archives', href: 'archives.html', icone: 'archives' }
  ];
  /* Frappeurs et lanceurs côte à côte : une ligne par sujet */
  var PAIRES = [
    { label: 'Par année', frappeurs: 'archives-frappeurs.html', lanceurs: 'archives-lanceurs.html' },
    { label: 'Carrières', frappeurs: 'frappeurs-carriere.html', lanceurs: 'lanceurs-carriere.html' },
    { label: 'Records', frappeurs: 'frappeurs-records.html', lanceurs: 'lanceurs-records.html' }
  ];
  var LIGUE = [
    { label: 'Direction', href: 'contact.html', icone: 'direction' },
    { label: 'Nous joindre', href: 'nous-contacter.html', icone: 'courriel' },
    { label: 'Médias', href: 'revue-presse.html', icone: 'medias' },
    { label: 'Liens utiles', href: 'liens-utiles.html', icone: 'lien' }
  ];

  var ICONES = {
    maison: '<path d="M3 11.5 12 4l9 7.5"/><path d="M5.5 10v9.5h5v-5h3v5h5V10"/>',
    calendrier: '<rect x="3.5" y="5" width="17" height="15" rx="2.5"/><path d="M3.5 9.5h17M8 3v4M16 3v4"/>',
    podium: '<path d="M9 20V9h6v11M3 20v-6h6M15 20v-8h6v8M2 20h20"/>',
    stats: '<path d="M4 20V10M10 20V4M16 20v-7M22 20H2"/>',
    equipes: '<circle cx="9" cy="8" r="3.2"/><path d="M3 19c.6-3.3 3-5 6-5s5.4 1.7 6 5"/><circle cx="17" cy="9" r="2.4"/><path d="M16 14c2.6 0 4.4 1.4 5 4"/>',
    plus: '<circle cx="5" cy="12" r="1.6"/><circle cx="12" cy="12" r="1.6"/><circle cx="19" cy="12" r="1.6"/>',
    joueur: '<circle cx="12" cy="7.5" r="3.5"/><path d="M5 20c.8-4 3.6-6 7-6s6.2 2 7 6"/>',
    carte: '<rect x="5" y="3" width="14" height="18" rx="2.5"/><circle cx="12" cy="10" r="2.6"/><path d="M8.5 17c.6-1.8 1.9-2.7 3.5-2.7s2.9.9 3.5 2.7"/>',
    balle: '<circle cx="12" cy="12" r="8.5"/><path d="M7.2 5.2c1.9 2 2.9 4.3 2.9 6.8s-1 4.8-2.9 6.8M16.8 5.2c-1.9 2-2.9 4.3-2.9 6.8s1 4.8 2.9 6.8"/>',
    trophee: '<path d="M8 4h8v5a4 4 0 0 1-8 0V4Z"/><path d="M8 6H5v1.5A3.5 3.5 0 0 0 8.5 11M16 6h3v1.5A3.5 3.5 0 0 1 15.5 11M12 13v4M8.5 20h7M10 17h4"/>',
    terrain: '<path d="M12 21s-6.5-6-6.5-11a6.5 6.5 0 0 1 13 0c0 5-6.5 11-6.5 11Z"/><circle cx="12" cy="10" r="2.3"/>',
    livre: '<path d="M4 5.5C6.5 4.5 9.5 4.5 12 6c2.5-1.5 5.5-1.5 8-.5V19c-2.5-1-5.5-1-8 .5-2.5-1.5-5.5-1.5-8-.5V5.5Z"/><path d="M12 6v13.5"/>',
    temple: '<path d="M3 9 12 4l9 5M5 9v9M9.5 9v9M14.5 9v9M19 9v9M3 20h18"/>',
    archives: '<rect x="3.5" y="4" width="17" height="5" rx="1.2"/><path d="M5 9v10h14V9M10 13h4"/>',
    direction: '<circle cx="12" cy="8" r="3.4"/><path d="M5.5 20c.7-3.6 3.3-5.6 6.5-5.6s5.8 2 6.5 5.6"/><path d="m12 14.4-1 2.6 1 1.2 1-1.2-1-2.6"/>',
    courriel: '<rect x="3.5" y="5.5" width="17" height="13" rx="2.2"/><path d="m4.5 7 7.5 6 7.5-6"/>',
    medias: '<rect x="3.5" y="6" width="13" height="12" rx="2"/><path d="m16.5 10.5 4-2.5v8l-4-2.5"/>',
    lien: '<path d="M10 14a4 4 0 0 0 5.7 0l3-3a4 4 0 0 0-5.7-5.7l-1 1"/><path d="M14 10a4 4 0 0 0-5.7 0l-3 3a4 4 0 0 0 5.7 5.7l1-1"/>'
  };
  function icone(n) {
    return '<svg class="ln-ico" viewBox="0 0 24 24" aria-hidden="true" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">' + ICONES[n] + '</svg>';
  }

  var courante = (location.pathname.split('/').pop() || 'index.html').toLowerCase() || 'index.html';
  function actif(item) {
    return item.href === courante || (item.aussi || []).indexOf(courante) !== -1;
  }
  var dansPlus = !PRINCIPAL.some(actif);

  function lienPrincipal(item, cls) {
    var a = actif(item);
    return '<a class="' + cls + (item.ordiSeulement ? ' ln-ordi' : '') + '" href="' + item.href + '"' + (a ? ' aria-current="page"' : '') + '>' +
      (cls === 'ln-tab' ? icone(item.icone) : '') + '<span>' + (cls === 'ln-tab' ? item.label : (item.long || item.label)) + '</span></a>';
  }

  function courant(href) { return actif({ href: href }) ? ' aria-current="page"' : ''; }
  function tuile(l) {
    return '<a class="ln-tuile" href="' + l.href + '"' + courant(l.href) + '>' + icone(l.icone) + '<span>' + l.label + '</span></a>';
  }
  function section(cls, titre, contenu) {
    return '<section class="ln-sec ' + cls + '"><h2>' + titre + '</h2>' + contenu + '</section>';
  }
  function panneau() {
    var saison = window.LBMA_SAISON ? 'Saison ' + window.LBMA_SAISON : 'Saison en cours';
    return section('ln-sec-saison', saison, '<div class="ln-grille">' + SAISON.map(tuile).join('') + '</div>') +
      section('ln-sec-histoire', 'Histoire depuis 1976',
        '<div class="ln-grille">' + HISTOIRE.map(tuile).join('') + '</div>' +
        PAIRES.map(function (p) {
          return '<div class="ln-paire"><span>' + p.label + '</span>' +
            '<a href="' + p.frappeurs + '"' + courant(p.frappeurs) + ' aria-label="' + p.label + ', frappeurs">Frappeurs</a>' +
            '<a href="' + p.lanceurs + '"' + courant(p.lanceurs) + ' aria-label="' + p.label + ', lanceurs">Lanceurs</a></div>';
        }).join('')) +
      section('ln-sec-ligue', 'La ligue', '<div class="ln-grille">' + LIGUE.map(tuile).join('') + '</div>') +
      '<a class="ln-admin" href="admin.html">Accès des administrateurs et marqueurs</a>';
  }

  /* Pied de page discret, le même sur toutes les pages : une ligne fine sur le fond
     de la page, sans logo (il est déjà dans la barre du haut). Plus de menus ici :
     ils sont dans « Plus » et dans la barre du bas. */
  function piedDePage() {
    var f = document.querySelector('body > footer');
    if (!f) return;
    var an = f.querySelector('.lbma-annee');
    f.className = 'ln-pied';
    f.removeAttribute('style');
    f.innerHTML =
      '<div class="ln-pied-int">' +
        '<div class="ln-pied-liens">' +
          '<a href="https://www.facebook.com/groups/2400013274" target="_blank" rel="noopener">Facebook</a>' +
          '<a href="https://www.marqueur.com/baseball/mbr/tools/blg/index.php?nyx=1154" target="_blank" rel="noopener">Marqueur.com</a>' +
          '<a href="nous-contacter.html">Nous joindre</a>' +
        '</div>' +
        '<div class="ln-pied-bas"><span>© <span class="lbma-annee">' + (an ? an.textContent : (window.LBMA_SAISON || '')) + '</span> LBMA</span>' +
          '<a href="confidentialite.html">Confidentialité</a><a href="admin.html">Admin</a></div>' +
      '</div>';
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
        '<div class="ln-sections">' + panneau() + '</div>' +
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
    piedDePage();
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
    document.querySelectorAll('.stats-table th[data-col="equipe"], .stats-table td.team-col, .modal-table td:nth-child(2)').forEach(function (c) {
      if (c.dataset.lbmaLong === undefined) {
        var t = c.textContent.trim();
        var etoile = /\*\s*$/.test(t);                 // « HARFANGS * » : réserviste ou échange
        var cle = t.replace(/\s*\*\s*$/, '').toUpperCase();
        var abr = c.tagName === 'TH' ? (/^ÉQ(UIPE)?$/i.test(t) ? 'ÉQ' : null) : (ABREGE[cle] ? ABREGE[cle] + (etoile ? '*' : '') : null);
        if (!abr) return;
        c.dataset.lbmaLong = t; c.dataset.lbmaCourt = abr;
        if (c.tagName === 'TD') c.title = t.charAt(0) + t.slice(1).toLowerCase();
      }
      // Dans la fiche « vs Adversaires », l'adversaire est toujours en 2 lettres (ordi et cellulaire)
      var voulu = (court || c.closest('.modal-table')) ? c.dataset.lbmaCourt : c.dataset.lbmaLong;
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

  /* ---- Menus de saison : une seule règle partout ----
     Libellé « Saison » (aussi dans les séries). « (En cours) » seulement pour la
     saison active tant qu'elle n'a pas de champion des séries (table champions).
     Dès que le champion est inscrit, l'année s'affiche simplement. */
  var SELECTS = ['saisonSelect', 'anneeSelect'];
  var ANON = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhneXNraWF0cHBnYWVhYW1qaHhyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzA0OTgxNTQsImV4cCI6MjA4NjA3NDE1NH0.67KCcUWlJij-scDoCUvZpkiCle5-mHVmy-inRk96Tac';
  var enCours = null; // année « en cours », ou '' si aucune
  function etiqueter(sel) {
    if (enCours === null) return;
    Array.prototype.forEach.call(sel.options, function (o) {
      var base = o.textContent.replace(/\s*\(En cours\)\s*$/, '');
      var voulu = (enCours && o.value === enCours) ? base + ' (En cours)' : base;
      if (o.textContent !== voulu) o.textContent = voulu;
    });
  }
  function menusSaison() {
    var sels = SELECTS.map(function (id) { return document.getElementById(id); }).filter(Boolean);
    if (!sels.length) return;
    sels.forEach(function (sel) {
      var lab = sel.parentElement && sel.parentElement.querySelector('label');
      if (lab && /ann[ée]e des s[ée]ries/i.test(lab.textContent)) lab.textContent = 'Saison';
      new MutationObserver(function () { etiqueter(sel); }).observe(sel, { childList: true });
    });
    var pret = window.LBMA_SAISON_PRETE || Promise.resolve(window.LBMA_SAISON);
    pret.then(function (s) {
      s = String(s || window.LBMA_SAISON || '');
      return fetch('https://xgyskiatppgaeaamjhxr.supabase.co/rest/v1/champions?select=equipe&saison=eq.' + encodeURIComponent(s),
        { headers: { apikey: ANON, Authorization: 'Bearer ' + ANON } })
        .then(function (r) { return r.ok ? r.json() : []; })
        .then(function (rows) { enCours = (Array.isArray(rows) && rows.length) ? '' : s; });
    }).catch(function () { enCours = ''; })
      .then(function () { sels.forEach(etiqueter); });
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', menusSaison);
  else menusSaison();
})();
