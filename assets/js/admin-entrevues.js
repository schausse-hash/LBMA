/* LBMA — Admin « 📰 Médias » : entrevues de Jean-Christian Dionne
   Lit et modifie la table medias_entrevues (lue par entrevues.html et entrevue.html).
   - Liste avec recherche, catégorie (joueur actuel / légende) et état (visible / masquée).
   - Fenêtre de modification : nom, catégorie, sous-titre, texte avec une petite
     barre d'outils (Gras, Question, Intertitre, Normal), case « Visible sur le site ».
   - Pas de suppression : on masque l'entrevue (visible = non).
   Chargé par admin.html après lbma-jeton.js (jeton de session) et lbma-entrevues.js
   (nettoyage du texte). Les écritures passent par sbFetch d'admin.html. */
(function () {
  'use strict';

  var E = window.LBMA_ENTREVUES;
  var esc = E.esc;
  var liste = [];
  var enCours = null;            // entrevue ouverte dans la fenêtre (null = nouvelle)

  function avis(msg, type) { if (typeof toast === 'function') toast(msg, type || 'success'); }
  function $(id) { return document.getElementById(id); }

  /* ---------- Liste ---------- */
  function charger() {
    var boite = $('entrevuesListe');
    if (!boite) return;
    sbFetch('medias_entrevues?select=id,slug,nom,categorie,sous_titre,visible,updated_at&order=nom.asc,id.asc')
      .then(function (r) {
        if (r.status === 404) throw new Error('table');
        if (!r.ok) throw new Error('HTTP ' + r.status);
        return r.json();
      })
      .then(function (rows) { liste = E.trier(rows); afficher(); })
      .catch(function (e) {
        liste = [];
        boite.innerHTML = '<p class="ent-adm-note">' + (e.message === 'table'
          ? 'La table des entrevues n\'existe pas encore. Il faut appliquer sql/medias-entrevues-2026-11-26.sql, puis l\'import.'
          : 'Impossible de lire les entrevues pour l\'instant. Réessayez dans un moment.') + '</p>';
        compte();
      });
  }

  function compte() {
    var c = $('entrevuesCompte');
    if (!c) return;
    var vis = liste.filter(function (e) { return e.visible; }).length;
    var mas = liste.length - vis;
    c.textContent = liste.length ? (vis + (vis > 1 ? ' visibles' : ' visible') + (mas ? ' · ' + mas + (mas > 1 ? ' masquées' : ' masquée') : '')) : '';
  }

  function afficher() {
    var boite = $('entrevuesListe');
    var q = ($('entrevuesRecherche').value || '').trim().toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, '');
    var f = liste.filter(function (e) {
      return !q || String(e.nom).toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, '').indexOf(q) !== -1;
    });
    compte();
    if (!liste.length) { boite.innerHTML = '<p class="ent-adm-note">Aucune entrevue pour l\'instant.</p>'; return; }
    if (!f.length) { boite.innerHTML = '<p class="ent-adm-note">Aucune entrevue ne correspond à « ' + esc(q) + ' ».</p>'; return; }
    boite.innerHTML = f.map(function (e) {
      return '<div class="item-card ent-adm-ligne' + (e.visible ? '' : ' masquee') + '">' +
        '<div><h4>' + (e.categorie === 'legende' ? '⭐ ' : '🎙️ ') + esc(e.nom) + '</h4>' +
        '<p>' + esc(E.CATEGORIES[e.categorie] || e.categorie) + (e.visible ? '' : ' · <b>masquée</b>') + '</p></div>' +
        '<div class="action-btns">' +
          '<a class="btn btn-small ent-adm-voir" href="entrevue.html?e=' + encodeURIComponent(e.slug) + '" target="_blank" rel="noopener" title="Voir sur le site" aria-label="Voir l\'entrevue de ' + esc(e.nom) + ' sur le site">👁️<span class="ent-adm-mot"> Voir</span></a>' +
          '<button class="btn btn-primary btn-small" type="button" data-modifier="' + e.id + '" title="Modifier" aria-label="Modifier l\'entrevue de ' + esc(e.nom) + '">✏️<span class="ent-adm-mot"> Modifier</span></button>' +
        '</div></div>';
    }).join('');
  }

  /* ---------- Fenêtre de modification ---------- */
  function fenetre() {
    if ($('entrevueModal')) return;
    var m = document.createElement('div');
    m.id = 'entrevueModal';
    m.className = 'modal';
    m.innerHTML =
      '<div class="modal-content ent-adm-modal" role="dialog" aria-modal="true" aria-labelledby="entrevueTitre">' +
        '<div class="modal-header"><h2 id="entrevueTitre">🎙️ Entrevue</h2><button class="modal-close" type="button" data-fermer aria-label="Fermer">×</button></div>' +
        '<div class="modal-body">' +
          '<div class="ent-adm-deux">' +
            '<div class="form-group"><label for="entNomChamp">Nom du joueur</label><input type="text" id="entNomChamp" autocomplete="off"></div>' +
            '<div class="form-group"><label for="entCatChamp">Catégorie</label><select id="entCatChamp"><option value="actuel">Joueur actuel</option><option value="legende">Légende</option></select></div>' +
          '</div>' +
          '<div class="form-group"><label for="entSousChamp">Sous-titre (facultatif)</label><input type="text" id="entSousChamp" placeholder="Ex. : Joueur actuel de la LBMA"></div>' +
          '<div class="form-group"><label id="entTexteEtiquette">Texte de l\'entrevue</label>' +
            '<div class="ent-adm-outils" role="toolbar" aria-label="Mise en forme">' +
              '<button type="button" class="btn btn-small" data-format="gras" title="Gras"><b>G</b> Gras</button>' +
              '<button type="button" class="btn btn-small" data-format="question" title="Paragraphe en gras : une question">❓ Question</button>' +
              '<button type="button" class="btn btn-small" data-format="h3" title="Intertitre">Intertitre</button>' +
              '<button type="button" class="btn btn-small" data-format="p" title="Paragraphe normal">Normal</button>' +
            '</div>' +
            '<div id="entTexteChamp" class="ent-adm-texte" contenteditable="true" role="textbox" aria-multiline="true" aria-labelledby="entTexteEtiquette"></div>' +
            '<p class="ent-adm-aide">Entrée = nouveau paragraphe. Un texte collé de Word ou d\'un courriel garde le gras et les paragraphes, le reste est retiré.</p>' +
          '</div>' +
          '<label class="ent-adm-case"><input type="checkbox" id="entVisibleChamp"> Visible sur le site</label>' +
          '<div class="btn-group ent-adm-actions">' +
            '<button type="button" class="btn btn-success" id="entEnregistrer">💾 Enregistrer</button>' +
            '<button type="button" class="btn" data-fermer>Annuler</button>' +
          '</div>' +
        '</div>' +
      '</div>';
    document.body.appendChild(m);

    m.addEventListener('click', function (ev) {
      if (ev.target === m || ev.target.closest('[data-fermer]')) fermer();
      var b = ev.target.closest('[data-format]');
      if (b) formater(b.getAttribute('data-format'));
    });
    m.addEventListener('keydown', function (ev) { if (ev.key === 'Escape') fermer(); });
    $('entEnregistrer').addEventListener('click', enregistrer);

    var texte = $('entTexteChamp');
    try { document.execCommand('defaultParagraphSeparator', false, 'p'); } catch (e) {}
    texte.addEventListener('paste', function (ev) {
      var cb = ev.clipboardData;
      if (!cb) return;
      ev.preventDefault();
      var h = cb.getData('text/html');
      var propre = h ? E.nettoyer(h)
        : String(cb.getData('text/plain') || '').split(/\n\s*\n/).map(function (para) {
            return '<p>' + esc(para.trim()).replace(/\n/g, '<br>') + '</p>';
          }).join('');
      document.execCommand('insertHTML', false, propre);
    });
  }

  function blocCourant() {
    var sel = window.getSelection();
    if (!sel || !sel.rangeCount) return null;
    var n = sel.getRangeAt(0).startContainer;
    var texte = $('entTexteChamp');
    while (n && n !== texte) {
      if (n.nodeType === 1 && /^(P|H2|H3|H4|LI|BLOCKQUOTE)$/.test(n.tagName)) return n;
      n = n.parentNode;
    }
    return null;
  }

  function formater(quoi) {
    var texte = $('entTexteChamp');
    texte.focus();
    if (quoi === 'gras') { document.execCommand('bold'); return; }
    if (quoi === 'h3' || quoi === 'p') {
      document.execCommand('formatBlock', false, quoi);
      var b0 = blocCourant(); if (b0) b0.classList.remove('question');
      return;
    }
    if (quoi === 'question') {
      var b = blocCourant();
      if (!b || b.tagName !== 'P') { document.execCommand('formatBlock', false, 'p'); b = blocCourant(); }
      if (b) b.classList.toggle('question');
    }
  }

  function ouvrir(e) {
    fenetre();
    enCours = e || null;
    $('entrevueTitre').textContent = e ? '🎙️ ' + e.nom : '🎙️ Nouvelle entrevue';
    $('entNomChamp').value = e ? e.nom : '';
    $('entCatChamp').value = e ? e.categorie : 'actuel';
    $('entSousChamp').value = e ? (e.sous_titre || '') : '';
    $('entVisibleChamp').checked = e ? !!e.visible : true;
    $('entTexteChamp').innerHTML = e ? E.nettoyer(e.contenu) : '<p><br></p>';
    $('entEnregistrer').disabled = false;
    if (typeof openModal === 'function') openModal('entrevue'); else $('entrevueModal').classList.add('active');
    setTimeout(function () { $('entNomChamp').focus(); }, 30);
  }

  function modifier(id) {
    sbFetch('medias_entrevues?select=*&id=eq.' + encodeURIComponent(id))
      .then(function (r) { if (!r.ok) throw new Error('HTTP ' + r.status); return r.json(); })
      .then(function (rows) { if (!rows[0]) throw new Error('absente'); ouvrir(rows[0]); })
      .catch(function () { avis('Impossible d\'ouvrir cette entrevue.', 'danger'); });
  }

  function fermer() {
    if (typeof closeModal === 'function') closeModal('entrevue'); else $('entrevueModal').classList.remove('active');
    enCours = null;
  }

  function slugLibre(nom) {
    var base = E.slugDe(nom), s = base, i = 2;
    var pris = liste.map(function (e) { return e.slug; });
    while (pris.indexOf(s) !== -1) s = base + '-' + (i++);
    return s;
  }

  function enregistrer() {
    var nom = $('entNomChamp').value.trim();
    if (!nom) { avis('Le nom du joueur est requis.', 'danger'); $('entNomChamp').focus(); return; }
    var d = {
      nom: nom,
      categorie: $('entCatChamp').value === 'legende' ? 'legende' : 'actuel',
      sous_titre: $('entSousChamp').value.trim() || null,
      contenu: E.nettoyer($('entTexteChamp').innerHTML),
      visible: $('entVisibleChamp').checked
    };
    var bouton = $('entEnregistrer');
    bouton.disabled = true;
    var req = enCours
      ? sbFetch('medias_entrevues?id=eq.' + enCours.id, { method: 'PATCH', body: JSON.stringify(d), headers: { Prefer: 'return=representation' } })
      : sbFetch('medias_entrevues', { method: 'POST', body: JSON.stringify(Object.assign({ slug: slugLibre(nom) }, d)), headers: { Prefer: 'return=representation' } });
    req.then(function (r) {
        if (!r.ok) throw new Error('HTTP ' + r.status);
        return r.json();
      })
      .then(function (rows) {
        // La base renvoie 0 ligne quand le jeton n'a pas le droit (RLS) : on le dit clairement.
        if (!rows || !rows.length) throw new Error('droits');
        avis(enCours ? 'Entrevue enregistrée.' : 'Entrevue ajoutée.');
        fermer();
        charger();
      })
      .catch(function (e) {
        bouton.disabled = false;
        avis(e.message === 'droits'
          ? 'Rien n\'a été enregistré : il faut être connecté comme admin.'
          : 'Rien n\'a été enregistré. Vérifiez la connexion et réessayez.', 'danger');
      });
  }

  /* ---------- Démarrage ---------- */
  function brancher() {
    var r = $('entrevuesRecherche');
    if (r) r.addEventListener('input', afficher);
    var n = $('entrevuesNouvelle');
    if (n) n.addEventListener('click', function () { ouvrir(null); });
    var l = $('entrevuesListe');
    if (l) l.addEventListener('click', function (ev) {
      var b = ev.target.closest('[data-modifier]');
      if (b) modifier(b.getAttribute('data-modifier'));
    });
    // admin.html appelle loadMediasSB() avant que ce fichier soit chargé : on charge ici.
    charger();
  }

  window.LBMA_ADMIN_ENTREVUES = { charger: charger };
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', brancher); else brancher();
})();
