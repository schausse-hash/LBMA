/* LBMA — téléversement des photos (sécurité phase D, nov. 2026).
   Les buckets Supabase n'acceptent plus d'écriture anonyme. Le navigateur demande
   à /api/photo une adresse de dépôt signée (admin connecté seulement, jeton ajouté
   par lbma-jeton.js), puis y envoie la photo.
   Au passage, les grosses photos sont réduites (1600 px max, JPEG 85 %) : les cartes
   chargent beaucoup plus vite sur cellulaire.

   Utilisation :
     const url = await lbmaTeleverserPhoto('joueurs-photos', 'equipes/FAUCONS_2027.jpg', fichier);
     const url = await lbmaTeleverserPhoto('temple', lbmaNomPhoto('membre', fichier), fichier);
*/
(function () {
  var ANON = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhneXNraWF0cHBnYWVhYW1qaHhyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzA0OTgxNTQsImV4cCI6MjA4NjA3NDE1NH0.67KCcUWlJij-scDoCUvZpkiCle5-mHVmy-inRk96Tac';
  var MAX_COTE = 1600, QUALITE = 0.85, SEUIL = 400 * 1024;

  // Réduit une image JPEG/PNG/WebP trop grande. Le GIF (animé) est laissé tel quel.
  function reduire(fichier) {
    return new Promise(function (ok) {
      if (!/^image\/(jpeg|png|webp)$/.test(fichier.type)) return ok(fichier);
      var lecteur = new FileReader();
      lecteur.onerror = function () { ok(fichier); };
      lecteur.onload = function () {
        var img = new Image();
        img.onerror = function () { ok(fichier); };
        img.onload = function () {
          var w = img.naturalWidth, h = img.naturalHeight;
          var echelle = Math.min(1, MAX_COTE / Math.max(w, h));
          if (echelle === 1 && fichier.size <= SEUIL) return ok(fichier);
          var c = document.createElement('canvas');
          c.width = Math.round(w * echelle); c.height = Math.round(h * echelle);
          var ctx = c.getContext('2d');
          ctx.fillStyle = '#fff'; ctx.fillRect(0, 0, c.width, c.height); // fond blanc pour les PNG transparents
          ctx.drawImage(img, 0, 0, c.width, c.height);
          c.toBlob(function (b) { ok(b && b.size < fichier.size ? b : fichier); }, 'image/jpeg', QUALITE);
        };
        img.src = lecteur.result;
      };
      lecteur.readAsDataURL(fichier);
    });
  }

  // Extension finale : .jpg si l'image sera convertie, sinon celle du fichier.
  function extension(fichier) {
    if (/^image\/(jpeg|png|webp)$/.test(fichier.type)) return 'jpg';
    var e = (fichier.name.split('.').pop() || '').toLowerCase();
    return /^(jpg|jpeg|png|webp|gif)$/.test(e) ? e : 'jpg';
  }

  // Nom unique pour Temple / Direction : type_horodatage.ext (plus de « _new » qui s'écrasait).
  window.lbmaNomPhoto = function (type, fichier) {
    return type + '_' + Date.now() + '.' + extension(fichier);
  };
  // Nom unique pour une photo de joueur : nom_horodatage.ext
  window.lbmaNomPhotoJoueur = function (nom, fichier) {
    var base = String(nom || 'joueur').normalize('NFD').replace(/[̀-ͯ]/g, '')
      .replace(/[^a-zA-Z0-9]/g, '_').toLowerCase().slice(0, 80) || 'joueur';
    return base + '_' + Date.now() + '.' + extension(fichier);
  };

  window.lbmaReduirePhoto = reduire;

  // options.dejaReduite : ne pas réduire une 2e fois (outil « Alléger les photos »).
  window.lbmaTeleverserPhoto = async function (bucket, chemin, fichier, options) {
    if (!fichier) throw new Error('Aucun fichier choisi');
    if (!/^image\/(jpeg|png|webp|gif)$/.test(fichier.type)) throw new Error('Choisis une image JPEG, PNG, WebP ou GIF');
    var image = (options && options.dejaReduite) ? fichier : await reduire(fichier);
    if (image.size > 5 * 1024 * 1024) throw new Error('Image trop lourde (5 Mo maximum)');
    var type = image.type || fichier.type;

    var r = await fetch('/api/photo', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ bucket: bucket, chemin: chemin, type: type })
    });
    var d = await r.json().catch(function () { return {}; });
    if (!r.ok || !d.depot) throw new Error(d.error || ('Dépôt refusé (' + r.status + ')'));

    var envoi = await fetch(d.depot, {
      method: 'PUT',
      headers: { apikey: ANON, 'Content-Type': type, 'x-upsert': 'true', 'cache-control': '3600' },
      body: image
    });
    if (!envoi.ok) {
      var t = await envoi.text().catch(function () { return ''; });
      throw new Error('Envoi de la photo refusé (' + envoi.status + ') ' + t.slice(0, 120));
    }
    return d.publique;
  };
})();
