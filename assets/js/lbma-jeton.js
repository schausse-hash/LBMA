/* LBMA — ajoute le jeton de session aux requetes Supabase et /api/ (phase B securite).
   A inclure en PREMIER dans le <head> des pages qui ecrivent des donnees :
     <script src="assets/js/lbma-jeton.js"></script>
   Le jeton est emis par login_user et garde dans localStorage (lbma_admin_session).
   Cote base, les policies d'ecriture exigent l'en-tete x-lbma-token valide. */
(function () {
  if (window.__lbmaJetonInstalle) return;
  window.__lbmaJetonInstalle = true;

  function jeton() {
    try {
      var s = JSON.parse(localStorage.getItem('lbma_admin_session') || 'null');
      if (!s || !s.token) return '';
      if (s.expires && s.expires < Date.now()) return '';
      return s.token;
    } catch (e) { return ''; }
  }
  function cible(url) {
    return typeof url === 'string' && (url.indexOf('.supabase.co/rest/v1/') !== -1 || url.indexOf('/api/') === 0);
  }

  var fetchOriginal = window.fetch.bind(window);
  window.fetch = function (entree, options) {
    try {
      var url = typeof entree === 'string' ? entree : (entree && entree.url) || '';
      var t = jeton();
      if (t && cible(url)) {
        if (entree instanceof Request) {
          var h = new Headers(entree.headers);
          if (!h.has('x-lbma-token')) h.set('x-lbma-token', t);
          entree = new Request(entree, { headers: h });
        } else {
          options = Object.assign({}, options || {});
          var hd = new Headers(options.headers || {});
          if (!hd.has('x-lbma-token')) hd.set('x-lbma-token', t);
          options.headers = hd;
        }
      }
    } catch (e) { /* en cas de doute, laisser passer la requete telle quelle */ }
    return fetchOriginal(entree, options);
  };
})();
