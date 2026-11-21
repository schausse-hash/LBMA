/* LBMA — saison active, pour toutes les pages.
   La saison vient de saison_info (clé « saison_active »), qu'on change une seule fois
   par année (script sql/saison-2027.sql, étape 2). Plus aucune page n'a à être retouchée.

   À inclure dans le <head>, AVANT les scripts de la page :
     <script src="assets/js/lbma-saison.js"></script>
   Puis dans la page :
     var SAI = window.LBMA_SAISON;              // ex. « 2027 », disponible tout de suite
     <span class="lbma-saison">2026</span>      // remplacé automatiquement par la saison active
     <title>… LBMA {SAISON}</title>             // « {SAISON} » remplacé dans le titre de l'onglet

   Fonctionnement : la dernière saison connue est gardée dans le navigateur, ce qui la rend
   disponible tout de suite (sans attendre le réseau). On vérifie ensuite auprès de la base ;
   si la saison a changé (bascule de février), la page se recharge une fois, d'elle-même si
   on vient de l'ouvrir, sinon un bandeau propose de la recharger (pour ne pas perdre une saisie). */
(function () {
  'use strict';
  var DEFAUT = '2026'; // seulement pour un tout premier chargement hors ligne
  var CLE = 'lbma_saison_active';
  var URL_SB = 'https://xgyskiatppgaeaamjhxr.supabase.co/rest/v1/saison_info?cle=eq.saison_active&select=valeur&limit=1';
  var ANON = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhneXNraWF0cHBnYWVhYW1qaHhyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzA0OTgxNTQsImV4cCI6MjA4NjA3NDE1NH0.67KCcUWlJij-scDoCUvZpkiCle5-mHVmy-inRk96Tac';
  var ouverture = Date.now();

  function valide(s) { return /^\d{4}$/.test(String(s || '')); }
  function lire() { try { return localStorage.getItem(CLE); } catch (e) { return null; } }
  function garder(s) { try { localStorage.setItem(CLE, s); } catch (e) {} }

  var connue = lire();
  window.LBMA_SAISON = valide(connue) ? connue : DEFAUT;

  // Remplir les étiquettes d'année de la page
  function appliquer(s) {
    if (document.title.indexOf('{SAISON}') !== -1) document.title = document.title.replace(/\{SAISON\}/g, s);
    var els = document.querySelectorAll('.lbma-saison');
    for (var i = 0; i < els.length; i++) els[i].textContent = s;
  }
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', function () { appliquer(window.LBMA_SAISON); });
  } else {
    appliquer(window.LBMA_SAISON);
  }

  function bandeau(s) {
    var b = document.createElement('div');
    b.setAttribute('role', 'alert');
    b.style.cssText = 'position:fixed;left:0;right:0;bottom:0;z-index:99999;background:#1E3A5F;color:#fff;padding:.75rem 1rem;' +
      'font-family:Arial,sans-serif;font-size:14px;display:flex;gap:1rem;align-items:center;justify-content:center;flex-wrap:wrap';
    b.innerHTML = 'La saison active est maintenant <strong>' + s + '</strong>. ' +
      '<button style="background:#D4AF37;border:0;padding:.4rem .9rem;font-weight:bold;cursor:pointer">Recharger la page</button>';
    b.querySelector('button').onclick = function () { location.reload(); };
    document.body.appendChild(b);
  }

  // Vérifier auprès de la base
  window.LBMA_SAISON_PRETE = fetch(URL_SB, { headers: { apikey: ANON, Authorization: 'Bearer ' + ANON } })
    .then(function (r) { return r.ok ? r.json() : null; })
    .then(function (rows) {
      var s = rows && rows[0] && String(rows[0].valeur).trim();
      if (!valide(s)) return window.LBMA_SAISON;
      garder(s);
      if (s !== window.LBMA_SAISON) {
        if (Date.now() - ouverture < 4000 && !sessionStorage.getItem('lbma_saison_recharge')) {
          try { sessionStorage.setItem('lbma_saison_recharge', '1'); } catch (e) {}
          location.reload();
        } else if (document.body) {
          bandeau(s);
        }
      }
      return s;
    })
    .catch(function () { return window.LBMA_SAISON; });
})();
