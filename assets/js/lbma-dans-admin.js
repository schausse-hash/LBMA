/* LBMA — pages d'outil affichées DANS l'admin.
   admin.html charge ces pages (cartes joueurs, ordre de repêchage, vérification du calendrier,
   backup) dans un cadre, avec ?dans-admin=1 : le menu de côté de l'admin reste visible.
   À inclure dans le <head> de la page :
     <script src="assets/js/lbma-dans-admin.js"></script>
   Dans ce mode, la classe « dans-admin » est ajoutée à <html> et les éléments marqués
   class="hors-admin" (l'en-tête de la page, le bouton « ← Admin ») sont cachés.
   Ouverte seule (sans ?dans-admin=1), la page ne change pas. */
(function () {
  if (!/[?&]dans-admin=1/.test(location.search)) return;
  document.documentElement.classList.add('dans-admin');
  var css = document.createElement('style');
  css.textContent = 'html.dans-admin .hors-admin{display:none!important}html.dans-admin body{min-height:0}';
  document.head.appendChild(css);
})();
