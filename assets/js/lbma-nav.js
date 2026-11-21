/* =====================================================================
   LBMA — Navigation partagée (source unique de vérité)
   VARIANTE B « Tableau du stade » — branche test ui-test-b-tradition
   ---------------------------------------------------------------------
   Ordi : barre marine ; Calendrier, Classement et Statistiques en accès
   direct, puis trois menus regroupés (Saison, Histoire, La ligue).
   Cellulaire : bouton « Menu » qui ouvre un plein écran, et une rangée
   de raccourcis (Calendrier, Classement, Stats) toujours visible.
   Pour modifier le menu du site entier : éditer CE fichier seulement.
   ===================================================================== */
(function () {
  'use strict';

  var DIRECT = [
    { label: 'Calendrier',   href: 'calendrier.html' },
    { label: 'Classement',   href: 'classement-equipes.html' },
    { label: 'Statistiques', court: 'Stats', href: 'stats-frappeurs.html', aussi: ['stats-lanceurs.html', 'stats-series.html'] }
  ];

  var GROUPES = [
    { titre: 'Saison', liens: [
      { label: 'Équipes', href: 'equipes.html' },
      { label: 'Joueurs', href: 'joueurs.html' },
      { label: 'Cartes de joueurs', href: 'carte-joueurs.html' },
      { label: 'Stats des frappeurs', href: 'stats-frappeurs.html' },
      { label: 'Stats des lanceurs', href: 'stats-lanceurs.html' },
      { label: 'Séries éliminatoires', href: 'stats-series.html' },
      { label: 'Terrains', href: 'terrains.html' },
      { label: 'Règlements', href: 'reglements.html' }
    ]},
    { titre: 'Histoire', liens: [
      { label: 'Saisons et champions depuis 1976', href: 'archives-saisons.html' },
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
      { label: 'Liens utiles', href: 'liens-utiles.html' },
      { label: 'Accès administrateurs', href: 'admin.html', discret: true }
    ]}
  ];

  var courante = (location.pathname.split('/').pop() || 'index.html').toLowerCase() || 'index.html';
  function estActif(l) { return l.href === courante || (l.aussi || []).indexOf(courante) !== -1; }
  function attr(l) { return estActif(l) ? ' aria-current="page"' : ''; }

  function groupeActif(g) { return g.liens.some(estActif) && !DIRECT.some(estActif); }

  function construire() {
    var direct = DIRECT.map(function (l) { return '<a class="tn-direct" href="' + l.href + '"' + attr(l) + '>' + l.label + '</a>'; }).join('');
    var menus = GROUPES.map(function (g, i) {
      return '<div class="tn-menu">' +
        '<button type="button" class="tn-declencheur" aria-expanded="false" aria-controls="tn-g' + i + '"' + (groupeActif(g) ? ' data-actif' : '') + '>' + g.titre + '</button>' +
        '<div class="tn-deroulant" id="tn-g' + i + '" hidden>' + g.liens.map(function (l) {
          return '<a href="' + l.href + '"' + attr(l) + (l.discret ? ' class="tn-discret"' : '') + '>' + l.label + '</a>';
        }).join('') + '</div></div>';
    }).join('');
    var plein = GROUPES.map(function (g) {
      return '<section><h2>' + g.titre + '</h2>' + g.liens.map(function (l) {
        return '<a href="' + l.href + '"' + attr(l) + (l.discret ? ' class="tn-discret"' : '') + '>' + l.label + '</a>';
      }).join('') + '</section>';
    }).join('');
    var rangee = [{ label: 'Accueil', href: 'index.html' }].concat(DIRECT).map(function (l) {
      return '<a href="' + l.href + '"' + attr(l) + '>' + (l.court || l.label) + '</a>';
    }).join('');
    return '' +
      '<div class="tn-barre">' +
        '<a href="index.html" class="tn-logo" aria-label="LBMA, accueil"><img src="logo-lbma.jpg" alt=""><span>LBMA</span></a>' +
        '<div class="tn-liens">' + direct + menus + '</div>' +
        '<button type="button" class="tn-menu-btn" aria-expanded="false" aria-controls="tn-plein">Menu</button>' +
      '</div>' +
      '<div class="tn-rangee" aria-label="Raccourcis">' + rangee + '</div>' +
      '<div class="tn-plein" id="tn-plein" hidden><div class="tn-plein-int">' +
        '<div class="tn-plein-direct">' + [{ label: 'Accueil', href: 'index.html' }].concat(DIRECT).map(function (l) {
          return '<a href="' + l.href + '"' + attr(l) + '>' + l.label + '</a>';
        }).join('') + '</div>' + plein + '</div></div>';
  }

  function brancher(root) {
    var menus = root.querySelectorAll('.tn-menu');
    function fermerTout(sauf) {
      menus.forEach(function (m) {
        if (m === sauf) return;
        m.querySelector('.tn-declencheur').setAttribute('aria-expanded', 'false');
        m.querySelector('.tn-deroulant').hidden = true;
      });
    }
    menus.forEach(function (m) {
      var b = m.querySelector('.tn-declencheur'), d = m.querySelector('.tn-deroulant');
      b.addEventListener('click', function (e) {
        e.stopPropagation();
        var o = d.hidden; fermerTout(m);
        d.hidden = !o; b.setAttribute('aria-expanded', o ? 'true' : 'false');
      });
    });
    document.addEventListener('click', function (e) { if (!e.target.closest('.tn-menu')) fermerTout(); });

    var btn = root.querySelector('.tn-menu-btn'), plein = root.querySelector('.tn-plein');
    btn.addEventListener('click', function () {
      var o = plein.hidden;
      plein.hidden = !o; btn.setAttribute('aria-expanded', o ? 'true' : 'false');
      btn.textContent = o ? 'Fermer' : 'Menu';
      document.documentElement.classList.toggle('tn-ouvert', o);
    });
    document.addEventListener('keydown', function (e) {
      if (e.key !== 'Escape') return;
      fermerTout();
      if (!plein.hidden) btn.click();
    });
  }

  function render() {
    var root = document.getElementById('lbma-nav-root');
    if (!root) return;
    document.documentElement.classList.add('lbma-theme');
    root.innerHTML = construire();
    brancher(root);
  }

  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', render);
  else render();
})();
