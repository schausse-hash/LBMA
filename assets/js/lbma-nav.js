/* =====================================================================
   LBMA — Navigation partagée (source unique de vérité)
   ---------------------------------------------------------------------
   Injecte le menu principal dans <nav id="lbma-nav-root"></nav>.
   Pour modifier le menu du site entier : éditer CE fichier seulement.

   Pages volontairement exclues (menu propre) : admin*, pointage,
   tutoriel, tutoriel-pointage. Elles n'incluent simplement pas ce script.
   ===================================================================== */
(function () {
  'use strict';

  /* ---- Définition du menu (ordre = ordre d'affichage) ---- */
  var MENU = [
    { label: 'Accueil',      href: 'index.html' },
    { label: 'Équipes',      href: 'equipes.html' },
    { label: 'Joueurs', children: [
        { label: '🏃 Liste des joueurs', href: 'joueurs.html' },
        { label: '🃏 Cartes de joueurs', href: 'carte-joueurs.html' }
    ]},
    { label: 'Calendrier',   href: 'calendrier.html' },
    { label: 'Terrains',     href: 'terrains.html' },
    { label: 'Statistiques', children: [
        { label: '🏆 Classement',           href: 'classement-equipes.html' },
        { label: '⚾ Frappeurs',            href: 'stats-frappeurs.html' },
        { label: '🎯 Lanceurs',             href: 'stats-lanceurs.html' },
        { label: '🏆 Séries Éliminatoires', href: 'stats-series.html' }
    ]},
    { label: 'Archives', children: [
        { label: '📊 Stats Frappeurs par Année', href: 'archives-frappeurs.html' },
        { label: '⭐ Frappeurs - Carrière',      href: 'frappeurs-carriere.html' },
        { label: '🏆 Frappeurs - Records',       href: 'frappeurs-records.html' },
        { label: '📊 Stats Lanceurs par Année',  href: 'archives-lanceurs.html' },
        { label: '⭐ Lanceurs - Carrière',       href: 'lanceurs-carriere.html' },
        { label: '🏆 Lanceurs - Records',        href: 'lanceurs-records.html' },
        { label: '📈 Classements Historiques',   href: 'classement-equipes.html' },
        { label: '🏛️ Temple de la Renommée',     href: 'temple-renommee.html' },
        { label: '📚 Archives Complètes',        href: 'archives.html' }
    ]},
    { label: 'Direction', href: 'contact.html' },
    { label: 'Admin',     href: 'admin.html', accent: true }
  ];

  /* ---- Page courante (nom de fichier) ---- */
  var current = (location.pathname.split('/').pop() || 'index.html').toLowerCase();
  if (current === '') current = 'index.html';

  var ACTIVE_STYLE = 'color:var(--primary);font-weight:700';

  function esc(s) { return String(s).replace(/"/g, '&quot;'); }

  function buildItem(item) {
    // Élément avec sous-menu
    if (item.children && item.children.length) {
      var childActive = item.children.some(function (c) { return c.href.toLowerCase() === current; });
      var parentStyle = childActive ? ' style="' + ACTIVE_STYLE + '"' : '';
      var sub = item.children.map(function (c) {
        var act = c.href.toLowerCase() === current ? ' style="' + ACTIVE_STYLE + '"' : '';
        return '<a href="' + esc(c.href) + '"' + act + '>' + c.label + '</a>';
      }).join('');
      return '<li class="dropdown"><a href="#"' + parentStyle + '>' + item.label + '</a>' +
             '<div class="dropdown-content">' + sub + '</div></li>';
    }
    // Lien simple
    var style = '';
    if (item.href.toLowerCase() === current) style = ' style="' + ACTIVE_STYLE + '"';
    else if (item.accent) style = ' style="color:var(--accent)"';
    return '<li><a href="' + esc(item.href) + '"' + style + '>' + item.label + '</a></li>';
  }

  function buildNav() {
    var items = MENU.map(buildItem).join('');
    return '' +
      '<div class="nav-container">' +
        '<a href="index.html" class="logo"><img src="logo-lbma.jpg" alt="LBMA"></a>' +
        '<div class="hamburger" onclick="var u=document.querySelector(\'nav ul\');if(u)u.classList.toggle(\'open\')">&#9776;</div>' +
        '<ul>' + items + '</ul>' +
      '</div>';
  }

  /* ---- Gestion du menu mobile / déroulants tactiles ---- */
  function attachMobile() {
    var isTouch = 'ontouchstart' in window || navigator.maxTouchPoints > 0;
    document.querySelectorAll('nav .dropdown > a').forEach(function (a) {
      a.addEventListener('click', function (e) {
        if (isTouch || window.innerWidth <= 768) {
          e.preventDefault();
          var parent = this.parentElement;
          document.querySelectorAll('nav .dropdown').forEach(function (d) {
            if (d !== parent) d.classList.remove('open');
          });
          parent.classList.toggle('open');
        }
      });
    });
    document.addEventListener('click', function (e) {
      if (!e.target.closest('nav')) {
        var ul = document.querySelector('nav ul');
        if (ul) ul.classList.remove('open');
        document.querySelectorAll('nav .dropdown').forEach(function (d) {
          d.classList.remove('open');
        });
      }
    });
  }

  function render() {
    var root = document.getElementById('lbma-nav-root');
    if (!root) return;            // page sans conteneur => on ne fait rien
    root.innerHTML = buildNav();
    attachMobile();
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', render);
  } else {
    render();
  }
})();
