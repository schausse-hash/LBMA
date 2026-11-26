/* LBMA — Admin version « appli » au cellulaire (branche test, nov. 2026)
   Ajoute, pour le cellulaire seulement (voir assets/css/admin-appli.css) :
   - les onglets du bas (selon le rôle) ;
   - l'écran « Plus », construit à partir du menu de côté existant
     (mêmes liens, mêmes rôles : un lien caché par le rôle n'y est pas) ;
   - un accueil : matchs d'aujourd'hui, raccourcis, chiffres. Les stats du
     site du tableau de bord restent en dessous, au complet ;
   - le choix Repêchage / Liste dans l'onglet Joueurs (superadmin).
   Aucune requête nouvelle : on lit les données déjà chargées par admin.html
   (calGames, calSeries) et on appelle ses fonctions existantes.
   À l'ordinateur, tout ce qui est ajouté reste caché (.app-seul). */
(function () {
  'use strict';
  if (window.__lbmaAppli) return;
  window.__lbmaAppli = true;

  // ---------- Session (lecture seule) ----------
  var S = {};
  try { S = JSON.parse(localStorage.getItem('lbma_admin_session') || '{}') || {}; } catch (e) { S = {}; }
  var ROLE = S.role || '';
  var SA = ROLE === 'superadmin';
  var POINTAGE_SEUL = ROLE === 'marqueur' || ROLE === 'coach';
  var ROLES = { superadmin: 'Superadmin', admin: 'Admin', marqueur: 'Marqueur', coach: 'Coach' };
  var main = document.querySelector('.main-content');
  if (!main || !document.getElementById('dashboard')) return;

  // ---------- Icônes (traits simples, comme le menu du site public) ----------
  var P = {
    accueil: '<path d="M3 11l9-7 9 7"/><path d="M5 10v10h14V10"/><path d="M10 20v-6h4v6"/>',
    pointage: '<rect x="5" y="4" width="14" height="17" rx="2"/><path d="M9 4h6v3H9z"/><path d="M9 12h6M9 16h4"/>',
    joueurs: '<circle cx="9" cy="8" r="3.2"/><path d="M3 20c0-3.3 2.7-6 6-6s6 2.7 6 6"/><circle cx="17" cy="9" r="2.5"/><path d="M16 14c2.8 0 5 2.2 5 5"/>',
    cal: '<rect x="3.5" y="5" width="17" height="15" rx="2"/><path d="M3.5 10h17M8 3v4M16 3v4"/>',
    plus: '<circle cx="5" cy="12" r="1.3"/><circle cx="12" cy="12" r="1.3"/><circle cx="19" cy="12" r="1.3"/>',
    mail: '<rect x="3" y="5.5" width="18" height="13" rx="2"/><path d="M3.5 7l8.5 6 8.5-6"/>',
    alerte: '<path d="M6 16V11a6 6 0 0 1 12 0v5l1.5 2h-15z"/><path d="M10 20.5a2 2 0 0 0 4 0"/>',
    report: '<rect x="3.5" y="5" width="17" height="15" rx="2"/><path d="M3.5 10h17M8 3v4M16 3v4"/><path d="M10 15h5m-2-2 2 2-2 2"/>',
    trophee: '<path d="M8 4h8v5a4 4 0 0 1-8 0z"/><path d="M8 6H5a3 3 0 0 0 3 4M16 6h3a3 3 0 0 1-3 4"/><path d="M12 13v4M8.5 20h7"/>',
    carte: '<rect x="5" y="3.5" width="14" height="17" rx="2"/><circle cx="12" cy="10" r="2.5"/><path d="M8.5 17c.6-1.8 2-2.8 3.5-2.8s2.9 1 3.5 2.8"/>',
    doc: '<path d="M7 3.5h7l4 4V20a.5.5 0 0 1-.5.5h-10A.5.5 0 0 1 6 20V4"/><path d="M14 3.5V8h4M9 12h6M9 16h6"/>',
    contrat: '<path d="M7 3.5h10v17H7z"/><path d="M10 8h4M10 12h4M10 16h2"/>',
    journal: '<rect x="3.5" y="5" width="17" height="14" rx="2"/><path d="M7 9h6v4H7zM15.5 9H17M15.5 13H17M7 16h10"/>',
    direction: '<circle cx="12" cy="7.5" r="3.5"/><path d="M5 20c.8-3.6 3.6-6 7-6s6.2 2.4 7 6"/>',
    equipes: '<path d="M12 3l7 3v5c0 4.5-3 8-7 10-4-2-7-5.5-7-10V6z"/>',
    ordre: '<path d="M5 6h2M5 12h2M5 18h2M10 6h9M10 12h9M10 18h9"/>',
    live: '<circle cx="12" cy="12" r="3"/><path d="M7.8 7.8a6 6 0 0 0 0 8.4M16.2 7.8a6 6 0 0 1 0 8.4M5 5a10 10 0 0 0 0 14M19 5a10 10 0 0 1 0 14"/>',
    balance: '<path d="M12 4v16M7 20h10M5 7h14"/><path d="M5 7l-2.5 6a3 3 0 0 0 5 0zM19 7l-2.5 6a3 3 0 0 0 5 0z"/>',
    echange: '<path d="M4 8h13l-3-3M20 16H7l3 3"/>',
    stats: '<path d="M4 20V10M10 20V4M16 20v-7M21 20H3"/>',
    verif: '<rect x="3.5" y="5" width="17" height="15" rx="2"/><path d="M3.5 10h17M9 15l2 2 4-4"/>',
    backup: '<ellipse cx="12" cy="6" rx="7" ry="2.5"/><path d="M5 6v6c0 1.4 3.1 2.5 7 2.5s7-1.1 7-2.5V6M5 12v6c0 1.4 3.1 2.5 7 2.5s7-1.1 7-2.5v-6"/>',
    cle: '<circle cx="8" cy="15" r="4"/><path d="M11 12l8-8M16 7l2 2M14 9l2 2"/>',
    crayon: '<path d="M4 20h4L19 9l-4-4L4 16z"/><path d="M13.5 6.5l4 4"/>',
    dollar: '<path d="M12 3v18M16.5 7.5C16 5.9 14.3 5 12 5c-2.6 0-4.5 1.2-4.5 3.2 0 4.6 9 2.3 9 7 0 2-2 3.3-4.5 3.3-2.4 0-4.2-1-4.8-2.8"/>',
    aide: '<circle cx="12" cy="12" r="8.5"/><path d="M9.6 9.5a2.5 2.5 0 1 1 3.4 2.3c-.6.3-1 .8-1 1.5v.4"/><circle cx="12" cy="17" r=".6"/>',
    web: '<circle cx="12" cy="12" r="8.5"/><path d="M3.5 12h17M12 3.5c2.5 2.5 3.5 5.5 3.5 8.5s-1 6-3.5 8.5c-2.5-2.5-3.5-5.5-3.5-8.5s1-6 3.5-8.5z"/>',
    sortie: '<path d="M14 4h5v16h-5M10 8l-4 4 4 4M6 12h10"/>',
    cadenas: '<rect x="5.5" y="10.5" width="13" height="10" rx="2"/><path d="M8.5 10.5V8a3.5 3.5 0 0 1 7 0v2.5"/>'
  };
  function ico(n, cls) { return '<svg class="app-ico ' + (cls || '') + '" viewBox="0 0 24 24" aria-hidden="true">' + (P[n] || P.doc) + '</svg>'; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"']/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]; }); }
  function sansEmoji(t) { return String(t || '').replace(/^[^\p{L}\p{N}]+/u, '').trim(); }

  // Élément du menu de côté qui ouvre une destination (on garde son clic d'origine)
  function itemMenu(cle) {
    return Array.prototype.find.call(document.querySelectorAll('#sidebarAdmin .menu-item'), function (m) {
      return (m.getAttribute('onclick') || '').indexOf(cle) !== -1;
    }) || null;
  }
  function ouvrirSection(id) { window.showSection(id, itemMenu("showSection('" + id + "'")); }
  function visible(el) { return !!el && getComputedStyle(el).display !== 'none'; }

  // ---------- Destinations des onglets ----------
  var ONGLETS = POINTAGE_SEUL ? [
    { cle: 'accueil', ico: 'accueil', txt: 'Accueil', go: function () { ouvrirSection('dashboard'); } },
    { cle: 'pointage', ico: 'pointage', txt: 'Pointage', go: function () { location.href = 'stats-live.html'; } },
    { cle: 'series', ico: 'trophee', txt: 'Séries', go: function () { location.href = 'stats-series-live.html'; } },
    { cle: 'reservistes', ico: 'echange', txt: 'Réservistes', go: function () { location.href = 'reservistes.html'; } },
    { cle: 'plus', ico: 'plus', txt: 'Plus', go: function () { window.showSection('appPlus', null); } }
  ] : [
    { cle: 'accueil', ico: 'accueil', txt: 'Accueil', go: function () { ouvrirSection('dashboard'); } },
    { cle: 'pointage', ico: 'pointage', txt: 'Pointage', go: function () { location.href = 'stats-live.html'; } },
    { cle: 'joueurs', ico: 'joueurs', txt: 'Joueurs', go: function () { ouvrirSection(SA ? 'joueursRepechage' : 'joueursList'); } },
    { cle: 'calendrier', ico: 'cal', txt: 'Calendrier', go: function () { ouvrirSection('calendrier'); } },
    { cle: 'plus', ico: 'plus', txt: 'Plus', go: function () { window.showSection('appPlus', null); } }
  ];
  var nav = document.createElement('nav');
  nav.className = 'app-onglets app-seul app-grille';
  nav.setAttribute('aria-label', 'Sections principales');
  nav.style.setProperty('--n', ONGLETS.length);
  nav.innerHTML = ONGLETS.map(function (o) {
    return '<button type="button" class="app-onglet" data-cle="' + o.cle + '">' + ico(o.ico) + '<span>' + o.txt + '</span></button>';
  }).join('');
  ONGLETS.forEach(function (o, i) { nav.children[i].addEventListener('click', o.go); });
  document.body.appendChild(nav);

  function ongletDe(id) {
    if (id === 'dashboard') return 'accueil';
    if (id === 'joueursRepechage' || id === 'joueursList') return 'joueurs';
    if (id === 'calendrier') return 'calendrier';
    return 'plus';
  }
  // Titre de la barre du haut : plus court (sans « (Supabase) »), « Accueil » pour le tableau de bord
  function majTitre(id) {
    var t = document.getElementById('titreMobile');
    if (!t) return;
    if (id === 'dashboard') t.textContent = 'Accueil';
    else t.textContent = t.textContent.replace(/\s*[(—–-]+\s*Supabase\)?\s*$/i, '').trim();
  }
  function majOnglets(id) {
    var cle = ongletDe(id);
    Array.prototype.forEach.call(nav.children, function (b) {
      if (b.getAttribute('data-cle') === cle) b.setAttribute('aria-current', 'page'); else b.removeAttribute('aria-current');
    });
  }

  // showSection garde tout son travail (contrôle des rôles compris) ; on met seulement les onglets à jour après
  var showSectionOrig = window.showSection;
  if (typeof showSectionOrig === 'function') {
    window.showSection = function (id, el) {
      var r = showSectionOrig.apply(this, arguments);
      var actif = document.querySelector('.admin-section.active');
      if (actif) { majOnglets(actif.id); majTitre(actif.id); }
      return r;
    };
  }

  // ---------- Écran « Plus » : les liens du menu de côté, en tuiles ----------
  var ICONES = [
    ['joueursList', 'joueurs'], ['admin-cartes', 'carte'], ['contratEquipe', 'contrat'], ['mailing', 'mail'],
    ["'calendrier'", 'cal'], ['temple', 'trophee'], ['reglements', 'doc'], ['presse', 'journal'], ['contacts', 'direction'],
    ['joueursRepechage', 'joueurs'], ['equipesSaison', 'equipes'], ['ordre-repechage', 'ordre'],
    ['verification-calendrier', 'verif'], ['backup-admin', 'backup'], ['statsLanceurs', 'stats'],
    ['repechage-admin', 'live'], ['stats-series-live', 'trophee'], ['stats-live', 'pointage'], ['benchage', 'balance'],
    ['reservistes', 'echange'], ["'users'", 'cle'], ['statsHistoriques', 'crayon'], ['couts', 'dollar'],
    ['tutoriel', 'aide'], ['joueurs.html', 'web'], ['equipes.html', 'web'], ['calendrier.html', 'web']
  ];
  var DIRECT = ['repechage-admin', 'stats-live', 'stats-series-live'];
  var GROUPES = { 'Repêchage & Équipes': 'Repêchage et équipes', 'Utilitaires': 'Outils', 'Live': 'En direct', 'Super Admin': 'Superadmin' };

  var plus = document.createElement('section');
  plus.id = 'appPlus';
  plus.className = 'admin-section';
  var nom = S.nom || S.user || '';
  var html = '<div class="page-header app-seul"><h1 class="app-masque">Plus</h1></div>' +
    '<div class="app-carte app-qui app-seul app-flex"><span class="rond">' + esc((nom.trim()[0] || '?').toUpperCase()) + '</span>' +
    '<div><b>' + esc(nom) + '</b><span class="app-badge ' + esc(ROLE) + '">' + esc(ROLES[ROLE] || ROLE) + '</span></div>' +
    '<button type="button" class="btn btn-secondary" data-app="logout">' + ico('sortie') + 'Déconnexion</button></div>';
  var tuiles = [];
  var groupe = null;
  function fermerGroupe() {
    if (groupe && groupe.items.length) {
      html += '<div class="app-groupe app-seul"><h2>' + esc(groupe.titre) + '</h2><div class="app-tuiles app-seul app-grille">' + groupe.items.join('') + '</div></div>';
    }
  }
  var navMenu = document.querySelector('#sidebarAdmin nav');
  if (navMenu) Array.prototype.forEach.call(navMenu.children, function (el) {
    if (el.classList.contains('menu-section')) {
      fermerGroupe();
      var t = el.textContent.trim();
      groupe = (t === 'Principal' || !visible(el)) ? { titre: '', items: [], cache: true } : { titre: GROUPES[t] || t, items: [] };
      return;
    }
    if (!el.classList.contains('menu-item') || !groupe || groupe.cache || !visible(el)) return;
    var oc = el.getAttribute('onclick') || '';
    var paire = groupe.titre === 'Voir le site' ? [0, 'web'] : ICONES.find(function (p) { return oc.indexOf(p[0]) !== -1; });
    var direct = DIRECT.some(function (d) { return oc.indexOf(d + '.html') !== -1; });
    var i = tuiles.length;
    tuiles.push(el);
    groupe.items.push('<button type="button" class="app-tuile' + (direct ? ' direct' : '') + '" data-tuile="' + i + '">' +
      (paire ? ico(paire[1]) : '<span class="emoji" aria-hidden="true">' + esc(el.textContent.trim().split(' ')[0]) + '</span>') +
      (el.classList.contains('superadmin-only') ? ico('cadenas', 'cadenas') : '') +
      '<span>' + esc(sansEmoji(el.textContent).replace(/\s*\/\s*/g, ' / ')) + '</span></button>');
  });
  fermerGroupe();
  plus.innerHTML = html;
  plus.addEventListener('click', function (e) {
    var t = e.target.closest('[data-tuile]');
    if (t) { tuiles[+t.getAttribute('data-tuile')].click(); return; }
    if (e.target.closest('[data-app="logout"]') && typeof window.logout === 'function') window.logout();
  });
  main.appendChild(plus);

  // ---------- Accueil : matchs d'aujourd'hui, raccourcis, chiffres ----------
  var COUL = { AIGLES: '#FF8C00', CONDORS: '#124FB2', DUCS: '#006400', FAUCONS: '#CC0000', HARFANGS: '#929292', VAUTOURS: '#330072' };
  function aujourdhui() {
    var d = new Date();
    return d.getFullYear() + '-' + String(d.getMonth() + 1).padStart(2, '0') + '-' + String(d.getDate()).padStart(2, '0');
  }
  var dateLongue = new Date().toLocaleDateString('fr-CA', { weekday: 'long', day: 'numeric', month: 'long' });
  dateLongue = dateLongue.charAt(0).toUpperCase() + dateLongue.slice(1);

  var RACCOURCIS = POINTAGE_SEUL ? [
    ['trophee', 'Pointer les séries', 'Stats live séries', function () { location.href = 'stats-series-live.html'; }],
    ['balance', 'Benchage', 'Temps de jeu', function () { location.href = 'benchage.html'; }],
    ['echange', 'Réservistes', 'Remplacements', function () { location.href = 'reservistes.html'; }],
    ['aide', 'Tutoriel', 'Aide au pointage', function () { window.open('tutoriel.html', '_blank'); }]
  ] : [
    ['alerte', 'Alerte au calendrier', 'Bannière et texto', function () { ouvrirSection('calendrier'); allerA('#alertesList'); }],
    ['report', 'Reporter un match', 'Changer date ou statut', function () { ouvrirSection('calendrier'); allerA('#gamesList'); }],
    ['mail', 'Envoi aux joueurs', 'Courriel de masse', function () { ouvrirSection('mailing'); }],
    ['echange', 'Réservistes', 'Remplacements', function () { location.href = 'reservistes.html'; }]
  ];
  function allerA(sel) {
    setTimeout(function () {
      var el = document.querySelector(sel);
      var box = el && (el.closest('.content-box') || el);
      if (!box) return;
      if (box.classList.contains('app-repli')) box.classList.add('ouvert');
      window.scrollTo(0, Math.max(0, box.getBoundingClientRect().top + window.scrollY - 70));
    }, 60);
  }

  var accueil = document.createElement('div');
  accueil.className = 'app-accueil app-seul';
  accueil.innerHTML =
    '<div class="app-salut"><h1>Bonjour ' + esc((nom.split(/[\s,]+/)[0]) || '') + '</h1>' +
    '<p>' + esc(dateLongue) + ' <span class="app-badge ' + esc(ROLE) + '">' + esc(ROLES[ROLE] || ROLE) + '</span></p></div>' +
    '<section class="app-carte"><div class="app-carte-tete"><h2>Matchs d\'aujourd\'hui</h2>' +
    (POINTAGE_SEUL ? '' : '<button type="button" data-app="cal">Calendrier</button>') + '</div>' +
    '<div id="appMatchs"><p class="app-vide">Chargement…</p></div></section>' +
    '<h2 class="app-titre">Raccourcis</h2>' +
    '<div class="app-raccourcis app-seul app-grille">' + RACCOURCIS.map(function (r, i) {
      return '<button type="button" class="app-raccourci" data-raccourci="' + i + '">' + ico(r[0]) + '<span>' + esc(r[1]) + '<small>' + esc(r[2]) + '</small></span></button>';
    }).join('') + '</div>' +
    '<section class="app-carte app-chiffres app-seul app-grille">' +
    '<div><b>6</b><span>Équipes</span></div><div><b data-copie="statJoueurs">0</b><span>Joueurs</span></div>' +
    '<div><b data-copie="statGames">0</b><span>Parties</span></div><div><b data-copie="statPlayed">0</b><span>Jouées</span></div></section>' +
    '<h2 class="app-titre">Visites du site</h2>';
  accueil.addEventListener('click', function (e) {
    var r = e.target.closest('[data-raccourci]');
    if (r) { RACCOURCIS[+r.getAttribute('data-raccourci')][3](); return; }
    if (e.target.closest('[data-app="cal"]')) ouvrirSection('calendrier');
  });
  var dash = document.getElementById('dashboard');
  dash.insertBefore(accueil, dash.firstChild);

  function majChiffres() {
    accueil.querySelectorAll('[data-copie]').forEach(function (b) {
      var src = document.getElementById(b.getAttribute('data-copie'));
      if (src) b.textContent = src.textContent;
    });
  }
  function ligneMatch(g, serie) {
    var heure = String(g.heure || '').replace(/^0/, '').replace('H', 'h');
    var final = g.status === 'final';
    var aScore = g.score_visiteur != null && g.score_local != null && (final || g.status === 'en_cours');
    function eq(e, s) {
      return '<div class="app-eq"><i style="background:' + (COUL[e] || '#5B6B80') + '"></i>' + esc(e ? e.charAt(0) + e.slice(1).toLowerCase() : '—') + (aScore ? '<b>' + esc(s) + '</b>' : '') + '</div>';
    }
    var page = serie ? 'stats-series-live.html' : 'stats-live.html';
    var droite = final ? '<span class="app-etat final">Final</span>'
      : g.status === 'en_cours' ? '<a class="btn btn-continuer" href="' + page + '">Continuer</a>'
      : g.status === 'reporte' ? '<span class="app-etat reporte">Reporté</span>'
      : g.status === 'annule' ? '<span class="app-etat annule">Annulé</span>'
      : '<a class="btn btn-pointer" href="' + page + '">Pointer</a>';
    var sous = serie ? (g.ronde || 'Séries') : (g.endroit || '');
    return '<div class="app-match"><div class="h">' + esc(heure) + '<small>' + (g.no_match ? 'no ' + esc(g.no_match) : '') + '</small></div>' +
      '<div>' + eq(g.visiteur, g.score_visiteur) + eq(g.local, g.score_local) + (sous ? '<div class="app-lieu">' + esc(sous) + '</div>' : '') + '</div>' + droite + '</div>';
  }
  function majMatchs() {
    var box = document.getElementById('appMatchs');
    if (!box) return;
    var jour = aujourdhui();
    var reg = (typeof calGames !== 'undefined' && Array.isArray(calGames)) ? calGames : [];
    var ser = (typeof calSeries !== 'undefined' && Array.isArray(calSeries)) ? calSeries : [];
    var liste = reg.filter(function (g) { return g.date === jour; }).map(function (g) { return ligneMatch(g, false); })
      .concat(ser.filter(function (g) { return g.date === jour; }).map(function (g) { return ligneMatch(g, true); }));
    box.innerHTML = liste.length ? liste.join('') : '<p class="app-vide">Aucun match aujourd\'hui.</p>';
  }
  function envelopper(nomFn, apres) {
    var f = window[nomFn];
    if (typeof f !== 'function') return;
    window[nomFn] = function () { var r = f.apply(this, arguments); try { apres(); } catch (e) { /* l'affichage appli ne doit jamais bloquer l'admin */ } return r; };
  }
  envelopper('renderGames', majMatchs);
  envelopper('renderSeries', majMatchs);
  envelopper('updateStats', majChiffres);
  majMatchs();
  majChiffres();

  // ---------- Onglet Joueurs : choix Repêchage / Liste (superadmin) ----------
  if (SA) ['joueursRepechage', 'joueursList'].forEach(function (id) {
    var sec = document.getElementById(id);
    if (!sec) return;
    var seg = document.createElement('div');
    seg.className = 'app-seg app-seul app-grille';
    seg.setAttribute('role', 'group');
    seg.setAttribute('aria-label', 'Vue des joueurs');
    seg.innerHTML = '<button type="button" aria-pressed="' + (id === 'joueursRepechage') + '" data-vers="joueursRepechage">Repêchage</button>' +
      '<button type="button" aria-pressed="' + (id === 'joueursList') + '" data-vers="joueursList">Liste</button>';
    seg.addEventListener('click', function (e) {
      var b = e.target.closest('[data-vers]');
      if (b && b.getAttribute('data-vers') !== id) ouvrirSection(b.getAttribute('data-vers'));
    });
    sec.insertBefore(seg, sec.firstChild);
  });

  // ---------- Calendrier : formulaires d'ajout et infos fixes repliés au cellulaire ----------
  Array.prototype.forEach.call(document.querySelectorAll('#calendrier .content-box > h2'), function (h) {
    var t = h.textContent;
    if (/^\s*➕/.test(t) || /Informations fixes/.test(t)) {
      var box = h.parentElement;
      box.classList.add('app-repli');
      h.setAttribute('role', 'button');
      h.setAttribute('tabindex', '0');
      h.setAttribute('aria-expanded', 'false');
      var bascule = function () { var o = box.classList.toggle('ouvert'); h.setAttribute('aria-expanded', o ? 'true' : 'false'); };
      h.addEventListener('click', bascule);
      h.addEventListener('keydown', function (e) { if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); bascule(); } });
    }
  });

  // État de départ
  var actif = document.querySelector('.admin-section.active');
  majOnglets(actif ? actif.id : 'dashboard');
  majTitre(actif ? actif.id : 'dashboard');
})();
