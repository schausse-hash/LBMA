/* LBMA — Entrevues de Jean-Christian Dionne (table medias_entrevues)
   Outils communs aux pages publiques (entrevues.html, entrevue.html)
   et à l'admin (assets/js/admin-entrevues.js) :
   - nettoyer() : ne garde que le HTML simple permis dans une entrevue
     (paragraphes, intertitres, gras, italique, listes, liens http/https).
     Tout le reste (scripts, styles, attributs) est retiré, à l'affichage
     comme à l'enregistrement.
   - trier() : ordre alphabétique français.
   - ARCHIVE : dossier des anciennes pages, utilisé en secours si la base
     ne répond pas. */
(function () {
  'use strict';

  var PERMIS = { P: 1, H2: 1, H3: 1, H4: 1, STRONG: 1, B: 1, EM: 1, I: 1, U: 1, BR: 1, UL: 1, OL: 1, LI: 1, A: 1, BLOCKQUOTE: 1 };
  var ENLEVER_AVEC_CONTENU = { SCRIPT: 1, STYLE: 1, IFRAME: 1, OBJECT: 1, EMBED: 1, TEMPLATE: 1, NOSCRIPT: 1, SVG: 1, MATH: 1, HEAD: 1, TITLE: 1, META: 1, LINK: 1 };

  function nettoyerNoeud(noeud, doc) {
    var enfants = Array.prototype.slice.call(noeud.childNodes);
    enfants.forEach(function (n) {
      if (n.nodeType === 3) return;                       // texte : on garde
      if (n.nodeType !== 1) { n.remove(); return; }       // commentaires, etc.
      var tag = n.tagName.toUpperCase();
      if (ENLEVER_AVEC_CONTENU[tag]) { n.remove(); return; }
      nettoyerNoeud(n, doc);
      if (tag === 'DIV') {                                 // un bloc collé (Word, courriel) devient un paragraphe
        var p = doc.createElement('p');
        while (n.firstChild) p.appendChild(n.firstChild);
        n.replaceWith(p);
        return;
      }
      if (!PERMIS[tag]) {                                  // balise inconnue : on garde seulement son texte
        while (n.firstChild) n.parentNode.insertBefore(n.firstChild, n);
        n.remove();
        return;
      }
      var question = tag === 'P' && n.classList.contains('question');
      var lien = tag === 'A' ? (n.getAttribute('href') || '') : '';
      Array.prototype.slice.call(n.attributes).forEach(function (a) { n.removeAttribute(a.name); });
      if (question) n.className = 'question';
      if (tag === 'A') {
        if (/^https?:\/\//i.test(lien.trim())) {
          n.setAttribute('href', lien.trim());
          n.setAttribute('target', '_blank');
          n.setAttribute('rel', 'noopener');
        } else {
          while (n.firstChild) n.parentNode.insertBefore(n.firstChild, n);
          n.remove();
        }
      }
    });
  }

  function nettoyer(html) {
    var doc = new DOMParser().parseFromString('<body>' + String(html || '') + '</body>', 'text/html');
    nettoyerNoeud(doc.body, doc);
    // paragraphes vides en trop
    Array.prototype.slice.call(doc.body.querySelectorAll('p')).forEach(function (p) {
      if (!p.textContent.trim() && !p.querySelector('br')) p.remove();
    });
    return doc.body.innerHTML.trim();
  }

  function esc(v) {
    return String(v == null ? '' : v).replace(/[&<>"']/g, function (c) {
      return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c];
    });
  }

  function trier(liste) {
    return liste.slice().sort(function (a, b) {
      return String(a.nom || '').localeCompare(String(b.nom || ''), 'fr', { sensitivity: 'base' });
    });
  }

  // Identifiant d'adresse à partir d'un nom : « Éric Béliveau » -> « eric-beliveau »
  function slugDe(nom) {
    return String(nom || '').normalize('NFD').replace(/[̀-ͯ]/g, '')
      .toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-+|-+$/g, '') || 'entrevue';
  }

  window.LBMA_ENTREVUES = {
    nettoyer: nettoyer,
    esc: esc,
    trier: trier,
    slugDe: slugDe,
    ARCHIVE: 'medias/entrevues-dionne/',
    CATEGORIES: { actuel: 'Joueur actuel', legende: 'Légende' }
  };
})();
