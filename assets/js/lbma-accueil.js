/* =====================================================================
   LBMA — Données de l'accueil (prochains matchs, résultats, classement)
   ---------------------------------------------------------------------
   Lecture seule, avec la clé publique. La page d'accueil appelle :
     LBMA_ACCUEIL.charger().then(function (d) { ... });
   d = { saison, saisonAffichee, calendrierAVenir, prochains[], enCours[],
         resultats[], classement[] }
   Si la saison active n'a encore aucun match (avant la publication du
   calendrier), on montre les résultats et le classement de la saison
   précédente, et calendrierAVenir = true.
   ===================================================================== */
(function () {
  'use strict';
  var SB = 'https://xgyskiatppgaeaamjhxr.supabase.co/rest/v1/';
  var K = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhneXNraWF0cHBnYWVhYW1qaHhyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzA0OTgxNTQsImV4cCI6MjA4NjA3NDE1NH0.67KCcUWlJij-scDoCUvZpkiCle5-mHVmy-inRk96Tac';

  var NOMS = { AIGLES: 'Aigles', CONDORS: 'Condors', DUCS: 'Ducs', FAUCONS: 'Faucons', HARFANGS: 'Harfangs', VAUTOURS: 'Vautours' };
  var COULEURS = { AIGLES: '#FF8C00', CONDORS: '#124FB2', DUCS: '#006400', FAUCONS: '#CC0000', HARFANGS: '#929292', VAUTOURS: '#330072' };
  var RONDES = { 'QUART-DE-FINALE': 'Quart de finale', 'DEMI-FINALE': 'Demi-finale', 'FINALE': 'Finale' };
  var JOURS = ['dimanche', 'lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi'];
  var MOISC = ['janv.', 'févr.', 'mars', 'avr.', 'mai', 'juin', 'juil.', 'août', 'sept.', 'oct.', 'nov.', 'déc.'];
  var MOIS = ['janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'];

  function get(chemin) {
    return fetch(SB + chemin, { headers: { apikey: K, Authorization: 'Bearer ' + K } })
      .then(function (r) { return r.ok ? r.json() : []; })
      .catch(function () { return []; });
  }

  function aujourdhui() {
    var d = new Date();
    return d.getFullYear() + '-' + String(d.getMonth() + 1).padStart(2, '0') + '-' + String(d.getDate()).padStart(2, '0');
  }

  function cle(g) { return (g.date || '') + ' ' + (g.heure || ''); }

  function lireSaison(s) {
    var champs = 'id,date,heure,visiteur,local,score_visiteur,score_local,endroit,status';
    return Promise.all([
      get('matchs_regulier?saison=eq.' + s + '&select=' + champs + ',special&order=date.asc,heure.asc'),
      get('matchs_series?saison=eq.' + s + '&select=' + champs + ',ronde&order=date.asc,heure.asc')
    ]);
  }

  function classer(reg) {
    var t = {};
    reg.forEach(function (g) {
      if (g.status !== 'final' || g.score_visiteur == null || g.score_local == null) return;
      [[g.visiteur, g.score_visiteur, g.score_local], [g.local, g.score_local, g.score_visiteur]].forEach(function (x) {
        var e = t[x[0]] || (t[x[0]] = { equipe: x[0], pj: 0, v: 0, d: 0, n: 0, pp: 0, pc: 0 });
        e.pj++; e.pp += x[1]; e.pc += x[2];
        if (x[1] > x[2]) e.v++; else if (x[1] < x[2]) e.d++; else e.n++;
      });
    });
    return Object.keys(t).map(function (k) {
      var e = t[k]; e.pts = e.v * 2 + e.n; e.diff = e.pp - e.pc; return e;
    }).sort(function (a, b) { return b.pts - a.pts || b.v - a.v || b.diff - a.diff; });
  }

  function construire(saison, saisonAffichee, reg, ser, aVenir) {
    var tous = reg.map(function (g) { g.type = 'r'; return g; })
      .concat(ser.map(function (g) { g.type = 's'; return g; }));
    var auj = aujourdhui();
    var prochains = tous.filter(function (g) { return (g.status === 'avenir' || g.status === 'en_cours') && g.date >= auj; })
      .sort(function (a, b) { return cle(a) < cle(b) ? -1 : 1; });
    var resultats = tous.filter(function (g) { return g.status === 'final' && g.score_visiteur != null && g.score_local != null; })
      .sort(function (a, b) { return cle(a) < cle(b) ? 1 : -1; });
    return {
      saison: saison,
      saisonAffichee: saisonAffichee,
      calendrierAVenir: aVenir,
      prochains: prochains.slice(0, 4),
      enCours: tous.filter(function (g) { return g.status === 'en_cours'; }),
      resultats: resultats.slice(0, 5),
      classement: classer(reg)
    };
  }

  function charger() {
    var p = window.LBMA_SAISON_PRETE || Promise.resolve(window.LBMA_SAISON);
    return p.then(function (s) {
      s = String(s || window.LBMA_SAISON || new Date().getFullYear());
      return lireSaison(s).then(function (r) {
        if (r[0].length || r[1].length) return construire(s, s, r[0], r[1], false);
        var avant = String(parseInt(s, 10) - 1);
        return lireSaison(avant).then(function (r2) { return construire(s, avant, r2[0], r2[1], true); });
      });
    });
  }

  /* ---- Petits formats partagés ---- */
  function nom(eq) { return NOMS[eq] || eq || ''; }
  function couleur(eq) { return COULEURS[eq] || '#888'; }
  function dateLongue(d) {
    var x = new Date(d + 'T12:00:00');
    return JOURS[x.getDay()] + ' ' + x.getDate() + ' ' + MOIS[x.getMonth()];
  }
  function dateCourte(d) {
    var x = new Date(d + 'T12:00:00');
    return x.getDate() + ' ' + MOISC[x.getMonth()];
  }
  function heure(h) {
    var m = String(h || '').match(/^(\d{1,2})\s*[hH:]\s*(\d{2})/);
    return m ? parseInt(m[1], 10) + ' h ' + m[2] : (h || '');
  }
  function etiquette(g) { return g.type === 's' ? (RONDES[g.ronde] || g.ronde || 'Séries') : 'Saison régulière'; }
  function esc(s) { return String(s == null ? '' : s).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function carte(endroit) {
    var q = (endroit || '').trim();
    if (q && !q.toLowerCase().startsWith('parc')) q = 'Parc ' + q;
    return 'https://www.google.com/maps/search/?api=1&query=' + encodeURIComponent(q + ', Montréal, QC');
  }

  window.LBMA_ACCUEIL = {
    charger: charger, nom: nom, couleur: couleur, dateLongue: dateLongue, dateCourte: dateCourte,
    heure: heure, etiquette: etiquette, esc: esc, carte: carte
  };
})();
