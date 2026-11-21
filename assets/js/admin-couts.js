/* LBMA — Page Super Admin « 💰 Coûts du site »
   Lit /api/couts (réservé au superadmin) et affiche :
   - le total du mois et des 12 derniers mois, en dollars canadiens
   - les abonnements (Supabase, Vercel, Resend, domaine…), modifiables
   - l'utilisation réelle Twilio (SMS + numéro) et le journal des envois
   - les quotas de courriels Resend (100/jour sur le plan gratuit)
   - un simulateur : combien coûte ce SMS envoyé à tous les joueurs ?
   Chargé par admin.html, après lbma-jeton.js (qui ajoute le jeton de session). */
(function () {
  'use strict';

  var COUL_FIXES = '#3A6EA5';   // abonnements
  var COUL_TWILIO = '#B8860B';  // SMS + numéro Twilio
  var donnees = null;
  var enEdition = null;         // id du coût fixe en cours de modification (ou 'nouveau')

  /* ---------- Outils ---------- */
  function esc(v) {
    return String(v == null ? '' : v).replace(/[&<>"']/g, function (c) {
      return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c];
    });
  }
  function argent(n, dec) {
    var d = dec == null ? 2 : dec;
    return (Number(n) || 0).toLocaleString('fr-CA', { minimumFractionDigits: d, maximumFractionDigits: d }) + ' $';
  }
  function cleMois(date) {
    // AAAA-MM à l'heure de Montréal
    return new Intl.DateTimeFormat('en-CA', { timeZone: 'America/Toronto', year: 'numeric', month: '2-digit' }).format(date).slice(0, 7);
  }
  function cleJour(date) {
    return new Intl.DateTimeFormat('en-CA', { timeZone: 'America/Toronto', year: 'numeric', month: '2-digit', day: '2-digit' }).format(date);
  }
  function nomMois(cle, court) {
    var p = cle.split('-');
    var d = new Date(Date.UTC(+p[0], +p[1] - 1, 15));
    return d.toLocaleDateString('fr-CA', { month: court ? 'short' : 'long', year: court ? '2-digit' : 'numeric', timeZone: 'UTC' });
  }
  function douzeMois() {
    var cles = [], d = new Date();
    d.setDate(15);
    for (var i = 11; i >= 0; i--) {
      var x = new Date(d.getFullYear(), d.getMonth() - i, 15);
      cles.push(cleMois(x));
    }
    return cles;
  }
  function jeton() {
    try { if (typeof session !== 'undefined' && session && session.token) return session.token; } catch (e) {}
    try { return (JSON.parse(localStorage.getItem('lbma_admin_session') || '{}').token) || ''; } catch (e) { return ''; }
  }
  function appelApi(methode, corps) {
    return fetch('/api/couts', {
      method: methode,
      headers: { 'Content-Type': 'application/json', 'x-lbma-token': jeton() },
      body: corps ? JSON.stringify(corps) : undefined
    }).then(function (r) {
      return r.json().catch(function () { return {}; }).then(function (j) {
        if (!r.ok) throw new Error(j.error || ('Erreur ' + r.status));
        return j;
      });
    });
  }
  function avis(msg, type) { if (typeof toast === 'function') toast(msg, type || 'success'); }

  /* ---------- Segments SMS (même règle que api/send-sms.js) ---------- */
  var GSM7 = '@£$¥èéùìòÇ\nØø\rÅåΔ_ΦΓΛΩΠΨΣΘΞÆæßÉ !"#¤%&\'()*+,-./0123456789:;<=>?¡ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÑÜ§¿abcdefghijklmnopqrstuvwxyzäöñüà';
  var GSM7_EXT = '^{}\\[~]|€\f';
  var PREFIXE_SMS = 'Un message de l exécutif de la LBMA:\n';
  function analyseSMS(txt) {
    var unites = 0, horsGsm = [];
    Array.from(txt).forEach(function (c) {
      if (GSM7.indexOf(c) !== -1) unites += 1;
      else if (GSM7_EXT.indexOf(c) !== -1) unites += 2;
      else if (horsGsm.indexOf(c) === -1) horsGsm.push(c);
    });
    if (!txt) return { encodage: 'GSM-7', caracteres: 0, segments: 0, limite: 160, horsGsm: [] };
    if (!horsGsm.length) return { encodage: 'GSM-7', caracteres: unites, segments: unites <= 160 ? 1 : Math.ceil(unites / 153), limite: unites <= 160 ? 160 : 153, horsGsm: [] };
    var n = 0;
    Array.from(txt).forEach(function (c) { n += c.codePointAt(0) > 0xFFFF ? 2 : 1; });
    return { encodage: 'Unicode', caracteres: n, segments: n <= 70 ? 1 : Math.ceil(n / 67), limite: n <= 70 ? 70 : 67, horsGsm: horsGsm };
  }
  // Exposé pour la confirmation d'envoi de SMS dans admin.html
  window.lbmaEstimationSMS = function (message, nbJoueurs) {
    var a = analyseSMS(PREFIXE_SMS + String(message || '').trim());
    var prix = (donnees && donnees.parametres.sms_prix_segment_usd && donnees.parametres.sms_prix_segment_usd.valeur) || 0.0079;
    var taux = (donnees && donnees.taux.valeur) || 1.4;
    var n = nbJoueurs || (donnees && donnees.joueurs.avec_telephone) || 70;
    return { segments: a.segments, encodage: a.encodage, horsGsm: a.horsGsm, joueurs: n, usd: a.segments * n * prix, cad: a.segments * n * prix * taux };
  };

  /* ---------- Calculs ---------- */
  function versCAD(montant, devise) { return devise === 'USD' ? montant * donnees.taux.valeur : montant; }
  function fixeMensuelCAD(f) {
    if (!f.actif) return 0;
    return versCAD(parseFloat(f.montant) || 0, f.devise) * (f.frequence === 'an' ? 1 / 12 : 1) * (parseFloat(f.part_lbma) || 0);
  }
  function calculer() {
    var d = donnees, mois = douzeMois(), courant = mois[mois.length - 1], aujourdhui = cleJour(new Date());
    var fixes = d.fixes.reduce(function (s, f) { return s + fixeMensuelCAD(f); }, 0);

    var twilioMois = {};
    if (d.twilio && d.twilio.ok) d.twilio.mois.forEach(function (m) { twilioMois[m.mois] = m; });

    var journalReel = d.journal.filter(function (j) { return !j.simulation; });
    var estimeSms = {}, courrielsMois = {}, parType = {}, courrielsJour = 0;
    journalReel.forEach(function (j) {
      var k = cleMois(new Date(j.created_at));
      if (j.canal === 'sms') estimeSms[k] = (estimeSms[k] || 0) + (parseFloat(j.cout_estime_usd) || 0);
      if (j.canal === 'courriel') {
        courrielsMois[k] = (courrielsMois[k] || 0) + (j.nb_reussis || 0);
        if (k === courant) parType[j.type_envoi] = (parType[j.type_envoi] || 0) + (j.nb_reussis || 0);
        if (cleJour(new Date(j.created_at)) === aujourdhui) courrielsJour += (j.nb_reussis || 0);
      }
    });
    d.anniversaires.forEach(function (a) {
      var k = String(a).slice(0, 7);
      courrielsMois[k] = (courrielsMois[k] || 0) + 1;
      if (k === courant) parType.anniversaire = (parType.anniversaire || 0) + 1;
      if (String(a).slice(0, 10) === aujourdhui) courrielsJour += 1;
    });

    var serie = mois.map(function (k) {
      var t = twilioMois[k];
      var twilioCAD = t ? t.total_usd * d.taux.valeur : (estimeSms[k] || 0) * d.taux.valeur;
      return { mois: k, fixes: fixes, twilio: twilioCAD, reel: !!t, total: fixes + twilioCAD };
    });
    var douze = serie.reduce(function (s, m) { return s + m.total; }, 0);
    return {
      mois: mois, courant: courant, fixes: fixes, serie: serie, douze: douze,
      ceMois: serie[serie.length - 1],
      courrielsMois: courrielsMois, courrielsJour: courrielsJour, parType: parType,
      twilioMois: twilioMois
    };
  }

  /* ---------- Rendu ---------- */
  function tuile(valeur, etiquette, sous, couleur) {
    return '<div class="stat-card" style="border-color:' + (couleur || 'var(--dark)') + '">' +
      '<div class="number">' + valeur + '</div><div class="label">' + etiquette + '</div>' +
      (sous ? '<div style="font-size:.72rem;color:#666;margin-top:.25rem">' + sous + '</div>' : '') + '</div>';
  }

  function graphique(c) {
    var max = Math.max.apply(null, c.serie.map(function (m) { return m.total; }).concat([1]));
    var H = 170;
    var barres = c.serie.map(function (m, i) {
      var hF = Math.round(m.fixes / max * H), hT = Math.round(m.twilio / max * H);
      var dernier = i === c.serie.length - 1;
      var info = nomMois(m.mois) + ' — total ' + argent(m.total) + ' · abonnements ' + argent(m.fixes) + ' · Twilio ' + argent(m.twilio) + (m.reel ? ' (réel)' : ' (estimé)');
      return '<div class="cout-col" data-info="' + esc(info) + '" tabindex="0" aria-label="' + esc(info) + '">' +
        (dernier ? '<div class="cout-val">' + argent(m.total, 0) + '</div>' : '') +
        '<div class="cout-pile" style="height:' + H + 'px">' +
          (hT > 0 ? '<div style="height:' + hT + 'px;background:' + COUL_TWILIO + ';border-radius:4px 4px 0 0;margin-bottom:2px"></div>' : '') +
          '<div style="height:' + hF + 'px;background:' + COUL_FIXES + ';border-radius:' + (hT > 0 ? '0' : '4px 4px 0 0') + '"></div>' +
        '</div>' +
        '<div class="cout-mois">' + esc(nomMois(m.mois, true)) + '</div></div>';
    }).join('');
    return '<div class="cout-legende">' +
        '<span><i style="background:' + COUL_FIXES + '"></i>Abonnements (part LBMA)</span>' +
        '<span><i style="background:' + COUL_TWILIO + '"></i>Twilio (SMS + numéro)</span>' +
      '</div>' +
      '<div class="cout-graph" style="position:relative">' +
        '<div class="cout-grille" style="height:' + H + 'px"><span>' + argent(max, 0) + '</span><span>' + argent(max / 2, 0) + '</span><span></span></div>' +
        '<div class="cout-barres">' + barres + '</div>' +
        '<div id="coutBulle" class="cout-bulle" hidden></div>' +
      '</div>' +
      '<p class="cout-note">Montants en dollars canadiens. Les abonnements sont calculés avec les montants actuels du tableau ci-dessous. ' +
      'Twilio : montant réel facturé (mois en cours = jusqu\'à aujourd\'hui).</p>';
  }

  function tableauFixes() {
    var lignes = donnees.fixes.map(function (f) {
      if (enEdition === f.id) return formulaireFixe(f);
      return '<tr style="' + (f.actif ? '' : 'opacity:.5') + '">' +
        '<td><strong>' + esc(f.service) + '</strong>' + (f.a_confirmer ? ' <span class="cout-badge">à confirmer</span>' : '') + '</td>' +
        '<td style="font-size:.78rem;color:#555;max-width:340px">' + esc(f.description) + '</td>' +
        '<td style="white-space:nowrap">' + argent(f.montant) + ' ' + esc(f.devise) + ' / ' + esc(f.frequence) + '</td>' +
        '<td>' + Math.round((parseFloat(f.part_lbma) || 0) * 1000) / 10 + ' %</td>' +
        '<td style="white-space:nowrap"><strong>' + argent(fixeMensuelCAD(f)) + '</strong></td>' +
        '<td class="action-btns" style="white-space:nowrap"><button class="btn btn-primary btn-small" data-cout-modifier="' + f.id + '">✏️</button> ' +
        '<button class="btn btn-danger btn-small" data-cout-supprimer="' + f.id + '">🗑️</button></td></tr>';
    }).join('');
    if (enEdition === 'nouveau') lignes += formulaireFixe({ id: null, service: '', description: '', montant: 0, devise: 'CAD', frequence: 'mois', part_lbma: 1, actif: true, a_confirmer: false });
    var total = donnees.fixes.reduce(function (s, f) { return s + fixeMensuelCAD(f); }, 0);
    return '<table class="data-table"><thead><tr><th>Service</th><th>Détail</th><th>Montant</th><th>Part LBMA</th><th>$ CA / mois</th><th></th></tr></thead>' +
      '<tbody>' + lignes + '</tbody>' +
      '<tfoot><tr><td colspan="4" style="text-align:right;font-family:Oswald,sans-serif">TOTAL DES ABONNEMENTS</td><td><strong>' + argent(total) + '</strong></td><td></td></tr></tfoot></table>' +
      '<div class="btn-group" style="margin-top:.6rem"><button class="btn btn-success" data-cout-ajouter>➕ Ajouter un coût</button></div>';
  }

  function formulaireFixe(f) {
    return '<tr class="cout-form"><td colspan="6"><div class="cout-form-grille">' +
      '<label>Service<input id="cfService" value="' + esc(f.service) + '"></label>' +
      '<label>Montant<input id="cfMontant" type="number" step="0.01" min="0" value="' + esc(f.montant) + '"></label>' +
      '<label>Devise<select id="cfDevise"><option' + (f.devise === 'CAD' ? ' selected' : '') + '>CAD</option><option' + (f.devise === 'USD' ? ' selected' : '') + '>USD</option></select></label>' +
      '<label>Fréquence<select id="cfFrequence"><option value="mois"' + (f.frequence === 'mois' ? ' selected' : '') + '>par mois</option><option value="an"' + (f.frequence === 'an' ? ' selected' : '') + '>par année</option></select></label>' +
      '<label>Part LBMA (%)<input id="cfPart" type="number" step="0.1" min="0" max="100" value="' + Math.round((parseFloat(f.part_lbma) || 0) * 1000) / 10 + '"></label>' +
      '<label class="cout-large">Détail<input id="cfDescription" value="' + esc(f.description) + '"></label>' +
      '<label class="cout-case"><input id="cfConfirmer" type="checkbox"' + (f.a_confirmer ? ' checked' : '') + '> À confirmer</label>' +
      '<label class="cout-case"><input id="cfActif" type="checkbox"' + (f.actif ? ' checked' : '') + '> Actif</label>' +
      '</div><div class="btn-group" style="margin-top:.5rem"><button class="btn btn-success" data-cout-enregistrer="' + (f.id || '') + '">💾 Enregistrer</button> ' +
      '<button class="btn" data-cout-annuler>Annuler</button></div></td></tr>';
  }

  function boiteTwilio(c) {
    var d = donnees, t = d.twilio;
    var html = '';
    if (!t || !t.ok) {
      html += '<p class="cout-alerte">Utilisation Twilio indisponible : ' + esc(t && t.erreur) + '. Les montants affichés pour les SMS sont des estimations tirées du journal des envois.</p>';
    } else {
      if (t.solde) html += '<p style="margin-bottom:.6rem">Solde du compte Twilio : <strong>' + argent(t.solde.montant) + ' ' + esc((t.solde.devise || '').toUpperCase()) + '</strong>' +
        (t.solde.montant < 10 ? ' <span class="cout-badge">à recharger bientôt</span>' : '') + '</p>';
      var lignes = t.mois.slice().reverse().filter(function (m) { return m.total_usd > 0 || m.sms_messages > 0; }).map(function (m) {
        return '<tr><td>' + esc(nomMois(m.mois)) + '</td><td>' + m.sms_messages + '</td><td>' + m.sms_segments + '</td>' +
          '<td>' + argent(m.sms_usd) + '</td><td>' + argent(m.numeros_usd) + '</td><td><strong>' + argent(m.total_usd * d.taux.valeur) + '</strong></td></tr>';
      }).join('');
      html += '<table class="data-table"><thead><tr><th>Mois</th><th>Messages</th><th>Segments</th><th>SMS ($ US)</th><th>Numéro ($ US)</th><th>Total ($ CA)</th></tr></thead><tbody>' +
        (lignes || '<tr><td colspan="6" style="color:#888">Aucune utilisation dans les 12 derniers mois.</td></tr>') + '</tbody></table>';
    }

    var envois = d.journal.filter(function (j) { return j.canal === 'sms' && j.type_envoi !== 'sms_reponse'; }).slice(0, 15);
    var reponses = d.journal.filter(function (j) { return j.type_envoi === 'sms_reponse'; });
    var attente = d.sms_non_transferes || [];
    if (attente.length) {
      html += '<div class="cout-alerte" style="margin-top:.75rem"><strong>⚠️ ' + attente.length + ' réponse' + (attente.length > 1 ? 's' : '') +
        ' de joueurs pas encore transférée' + (attente.length > 1 ? 's' : '') + ' par courriel</strong> (nouvel essai automatique à la prochaine réponse reçue) :' +
        '<ul class="cout-liste">' + attente.map(function (m) {
          return '<li><strong>' + esc(m.nom_joueur || m.de) + '</strong> — ' + esc(new Date(m.recu_le).toLocaleString('fr-CA', { dateStyle: 'medium', timeStyle: 'short' })) +
            ' : « ' + esc(m.texte) + ' »<br><span style="font-size:.72rem;color:#777">' + esc(m.erreur || '') + '</span></li>';
        }).join('') + '</ul></div>';
    }
    html += '<h3 class="cout-h3">Envois de SMS depuis le site</h3>';
    if (reponses.length) {
      html += '<p class="cout-note" style="margin:0 0 .5rem">💬 ' + reponses.length + ' réponse' + (reponses.length > 1 ? 's' : '') +
        ' de joueurs reçue' + (reponses.length > 1 ? 's' : '') + ' et transférée' + (reponses.length > 1 ? 's' : '') + ' par courriel (≈ ' +
        argent(reponses.reduce(function (s, j) { return s + (parseFloat(j.cout_estime_usd) || 0); }, 0) * d.taux.valeur) + ').</p>';
    }
    if (!envois.length) {
      html += '<p class="cout-note">Aucun envoi journalisé pour l\'instant. Le journal commence avec cette version de la page : chaque envoi de SMS y sera inscrit.</p>';
    } else {
      html += '<table class="data-table"><thead><tr><th>Date</th><th>Par</th><th>Message</th><th>Joueurs</th><th>Segments</th><th>Coût estimé</th></tr></thead><tbody>' +
        envois.map(function (j) {
          return '<tr style="' + (j.simulation ? 'opacity:.6' : '') + '"><td style="white-space:nowrap">' + esc(new Date(j.created_at).toLocaleString('fr-CA', { dateStyle: 'medium', timeStyle: 'short' })) + '</td>' +
            '<td>' + esc(j.demande_par) + '</td><td style="font-size:.78rem;max-width:300px">' + esc(j.sujet) + (j.simulation ? ' <span class="cout-badge">simulation</span>' : '') + '</td>' +
            '<td>' + j.nb_reussis + (j.nb_echecs ? ' <span style="color:var(--danger)">(' + j.nb_echecs + ' échec' + (j.nb_echecs > 1 ? 's' : '') + ')</span>' : '') + '</td>' +
            '<td>' + (j.segments || 0) + '</td><td>' + argent((parseFloat(j.cout_estime_usd) || 0) * d.taux.valeur) + '</td></tr>';
        }).join('') + '</tbody></table>';
    }
    return html;
  }

  function jauge(valeur, max, etiquette) {
    var pct = max ? Math.min(100, valeur / max * 100) : 0;
    var coul = pct >= 90 ? 'var(--danger)' : pct >= 70 ? '#b8860b' : COUL_FIXES;
    return '<div class="cout-jauge"><div class="cout-jauge-tete"><span>' + etiquette + '</span><strong>' + valeur.toLocaleString('fr-CA') + ' / ' + max.toLocaleString('fr-CA') + '</strong></div>' +
      '<div class="cout-jauge-fond"><div style="width:' + pct + '%;background:' + coul + '"></div></div></div>';
  }

  function boiteCourriels(c) {
    var p = donnees.parametres;
    var qJour = (p.resend_quota_jour && p.resend_quota_jour.valeur) || 100;
    var qMois = (p.resend_quota_mois && p.resend_quota_mois.valeur) || 3000;
    var nbCourriel = donnees.joueurs.avec_courriel || 0;
    var limLbma = Math.round(Number(p.lbma_courriels_jour && p.lbma_courriels_jour.valeur)) || 70;
    var html = jauge(c.courrielsJour, qJour, 'Aujourd\'hui') + jauge(c.courrielsMois[c.courant] || 0, qMois, 'Ce mois-ci');
    var noms = { courriel_masse: 'Envoi de masse', fiche: 'Fiches de vérification', anniversaire: 'Anniversaires (automatique)', sms_reponse_transfert: 'Réponses SMS transférées' };
    var rep = Object.keys(c.parType).map(function (k) { return '<li>' + esc(noms[k] || k) + ' : <strong>' + c.parType[k] + '</strong></li>'; }).join('');
    html += '<h3 class="cout-h3">Ce mois-ci</h3><ul class="cout-liste">' + (rep || '<li style="color:#888">Aucun courriel envoyé.</li>') + '</ul>';
    if (nbCourriel) {
      html += '<p class="cout-note">Un envoi de masse aux ' + nbCourriel + ' joueurs ' + esc(donnees.saison) + ' utilise ' + nbCourriel + ' des ' + limLbma + ' courriels que LBMA se permet par jour.' +
        (nbCourriel * 2 > limLbma ? ' Un envoi de masse et les fiches le même jour (' + nbCourriel * 2 + ') dépassent cette limite : <strong>l\'envoi s\'arrête de lui-même</strong> et se termine le lendemain avec le bouton « Reprendre ».' : '') + '</p>';
    }
    html += '<p class="cout-note">Plan gratuit Resend : 0 $. Les ' + qJour + ' courriels par jour sont <strong>partagés</strong> avec FaceHub et dentiste.com : LBMA s\'arrête à ' + limLbma + ' pour leur laisser de la place. Les jauges ci-dessus ne comptent que LBMA. Les anniversaires viennent de la tâche automatique quotidienne (table birthday_emails_sent).</p>';
    return html;
  }

  function boiteBd() {
    var b = donnees.base_de_donnees;
    if (!b || !b.octets) return '<p class="cout-note">Taille de la base indisponible.</p>';
    var mo = b.octets / 1024 / 1024, inclus = b.inclus_octets / 1024 / 1024;
    return jauge(Math.round(mo), Math.round(inclus), 'Base de données (Mo utilisés / inclus)') +
      '<p class="cout-note">Le forfait Pro inclut 8 Go par projet ; au-delà, environ 0,125 $ US par Go par mois. Il reste beaucoup de marge.</p>';
  }

  function boiteSimulateur() {
    var n = donnees.joueurs.avec_telephone || 0;
    return '<label class="cout-label">Message (le préfixe « Un message de l\'exécutif de la LBMA: » est ajouté automatiquement)</label>' +
      '<textarea id="coutSimTexte" rows="3" style="width:100%;padding:.5rem;border:2px solid var(--dark);font-family:inherit" placeholder="Ex. : Match remis à vendredi, être là à 18 h 30"></textarea>' +
      '<div style="display:flex;gap:1rem;align-items:center;margin-top:.5rem;flex-wrap:wrap"><label class="cout-label" style="margin:0">Joueurs <input id="coutSimJoueurs" type="number" min="1" value="' + (n || 70) + '" style="width:5rem;padding:.25rem;border:2px solid var(--dark)"></label></div>' +
      '<div id="coutSimResultat" class="cout-sim"></div>';
  }

  function majSimulateur() {
    var t = document.getElementById('coutSimTexte');
    if (!t) return;
    var n = parseInt(document.getElementById('coutSimJoueurs').value, 10) || 0;
    var a = analyseSMS(PREFIXE_SMS + t.value.trim());
    var prix = donnees.parametres.sms_prix_segment_usd ? donnees.parametres.sms_prix_segment_usd.valeur : 0.0079;
    var usd = a.segments * n * prix;
    var html = '<div><strong>' + a.caracteres + '</strong> caractères · encodage <strong>' + a.encodage + '</strong> · <strong>' + a.segments + '</strong> segment' + (a.segments > 1 ? 's' : '') + ' par joueur</div>' +
      '<div style="font-size:1.25rem;margin:.35rem 0">≈ <strong>' + argent(usd * donnees.taux.valeur) + '</strong> pour ' + n + ' joueurs <span style="font-size:.8rem;color:#666">(' + a.segments * n + ' segments × ' + prix.toLocaleString('fr-CA', { maximumFractionDigits: 4 }) + ' $ US, plus frais des transporteurs)</span></div>';
    if (a.horsGsm.length) {
      html += '<div class="cout-alerte" style="margin-top:.4rem">Ces caractères font passer le message en Unicode (70 caractères par segment au lieu de 160) : <strong>' +
        a.horsGsm.map(esc).join(' ') + '</strong>. Les remplacer (ex. « ê » → « e ») peut diviser le coût par deux.</div>';
    }
    document.getElementById('coutSimResultat').innerHTML = html;
  }

  function boiteParametres() {
    var p = donnees.parametres, t = donnees.taux;
    var libelles = {
      taux_usd_cad: 'Taux USD → CAD de secours',
      sms_prix_segment_usd: 'Prix d\'un segment SMS ($ US)',
      resend_quota_jour: 'Quota Resend par jour',
      resend_quota_mois: 'Quota Resend par mois',
      lbma_courriels_jour: 'Limite LBMA par jour (le reste : « Reprendre » le lendemain)'
    };
    var html = '<p style="margin-bottom:.6rem">Taux utilisé : <strong>1 $ US = ' + t.valeur.toLocaleString('fr-CA', { maximumFractionDigits: 4 }) + ' $ CA</strong> — ' + esc(t.source) + (t.date ? ' (' + esc(t.date) + ')' : '') + '</p>';
    html += '<table class="data-table"><tbody>' + Object.keys(libelles).map(function (k) {
      var v = p[k] ? p[k].valeur : '';
      return '<tr><td>' + libelles[k] + '<div style="font-size:.72rem;color:#777">' + esc(p[k] && p[k].description) + '</div></td>' +
        '<td style="white-space:nowrap"><input type="number" step="any" min="0" id="cp_' + k + '" value="' + esc(v) + '" style="width:7rem;padding:.25rem;border:2px solid var(--dark)"> ' +
        '<button class="btn btn-primary btn-small" data-cout-param="' + k + '">💾</button></td></tr>';
    }).join('') + '</tbody></table>';
    return html;
  }

  function rendre() {
    var racine = document.getElementById('coutsRoot');
    if (!racine || !donnees) return;
    var c = calculer();
    var nbJoueurs = Math.max(donnees.joueurs.avec_telephone || 0, donnees.joueurs.avec_courriel || 0);
    var t = donnees.twilio;
    var twilioCe = c.twilioMois[c.courant];

    racine.innerHTML =
      (donnees.envois_simules ? '<p class="cout-alerte">Environnement : <strong>' + esc(donnees.environnement) + '</strong> — les envois de SMS et de courriels sont simulés ici (rien ne part).</p>' : '') +
      '<div class="cards-grid">' +
        tuile(argent(c.ceMois.total), 'Ce mois-ci', nomMois(c.courant) + ' (en cours)') +
        tuile(argent(c.fixes), 'Abonnements / mois', 'part LBMA', COUL_FIXES) +
        tuile(argent(twilioCe ? twilioCe.total_usd * donnees.taux.valeur : 0), 'Twilio ce mois', twilioCe ? twilioCe.sms_messages + ' SMS' : (t && t.ok ? 'aucun SMS' : 'indisponible'), COUL_TWILIO) +
        tuile(argent(c.douze, 0), '12 derniers mois', nbJoueurs ? '≈ ' + argent(c.douze / nbJoueurs) + ' par joueur' : '') +
      '</div>' +
      '<div class="content-box"><h2>📈 Coût mensuel — 12 derniers mois</h2>' + graphique(c) + '</div>' +
      '<div class="content-box"><h2>🧾 Abonnements et frais fixes</h2>' + tableauFixes() + '</div>' +
      '<div class="cout-deux">' +
        '<div class="content-box"><h2>📱 SMS — Twilio</h2>' + boiteTwilio(c) + '</div>' +
        '<div class="content-box"><h2>📧 Courriels — Resend</h2>' + boiteCourriels(c) + '<h3 class="cout-h3">🗄️ Supabase</h3>' + boiteBd() + '</div>' +
      '</div>' +
      '<div class="cout-deux">' +
        '<div class="content-box"><h2>🧮 Combien coûte ce SMS ?</h2>' + boiteSimulateur() + '</div>' +
        '<div class="content-box"><h2>⚙️ Paramètres de calcul</h2>' + boiteParametres() + '</div>' +
      '</div>' +
      '<p class="cout-note">Mis à jour : ' + esc(new Date(donnees.genere_le).toLocaleString('fr-CA')) + ' · <a href="#" data-cout-rafraichir>Actualiser</a></p>';
    majSimulateur();
  }

  function charger() {
    var racine = document.getElementById('coutsRoot');
    if (!racine) return;
    racine.innerHTML = '<div class="content-box" style="text-align:center;color:#888">⏳ Chargement des coûts…</div>';
    appelApi('GET').then(function (d) {
      donnees = d;
      enEdition = null;
      rendre();
    }).catch(function (e) {
      racine.innerHTML = '<div class="content-box"><p class="cout-alerte">Impossible de charger les coûts : ' + esc(e.message) + '</p></div>';
    });
  }

  /* ---------- Événements ---------- */
  document.addEventListener('click', function (ev) {
    var el = ev.target.closest && ev.target.closest('[data-cout-modifier],[data-cout-supprimer],[data-cout-ajouter],[data-cout-annuler],[data-cout-enregistrer],[data-cout-param],[data-cout-rafraichir]');
    var racine = document.getElementById('coutsRoot');
    if (!el || !racine || !racine.contains(el)) return;
    ev.preventDefault();

    if (el.hasAttribute('data-cout-rafraichir')) return charger();
    if (el.hasAttribute('data-cout-modifier')) { enEdition = parseInt(el.getAttribute('data-cout-modifier'), 10); return rendre(); }
    if (el.hasAttribute('data-cout-ajouter')) { enEdition = 'nouveau'; return rendre(); }
    if (el.hasAttribute('data-cout-annuler')) { enEdition = null; return rendre(); }

    if (el.hasAttribute('data-cout-supprimer')) {
      var id = el.getAttribute('data-cout-supprimer');
      var f = donnees.fixes.find(function (x) { return String(x.id) === id; });
      var faire = function () {
        appelApi('POST', { action: 'fixe_supprimer', id: id }).then(function () { avis('Coût supprimé'); charger(); })
          .catch(function (e) { avis(e.message, 'danger'); });
      };
      return typeof confirm === 'function' ? confirm('Supprimer « ' + (f ? f.service : '') + ' » ?', faire) : faire();
    }

    if (el.hasAttribute('data-cout-enregistrer')) {
      var corps = {
        action: 'fixe_enregistrer',
        id: el.getAttribute('data-cout-enregistrer') || null,
        service: document.getElementById('cfService').value,
        description: document.getElementById('cfDescription').value,
        montant: document.getElementById('cfMontant').value,
        devise: document.getElementById('cfDevise').value,
        frequence: document.getElementById('cfFrequence').value,
        part_lbma: (parseFloat(document.getElementById('cfPart').value) || 0) / 100,
        a_confirmer: document.getElementById('cfConfirmer').checked,
        actif: document.getElementById('cfActif').checked
      };
      el.disabled = true;
      return appelApi('POST', corps).then(function () { avis('Coût enregistré'); charger(); })
        .catch(function (e) { el.disabled = false; avis(e.message, 'danger'); });
    }

    if (el.hasAttribute('data-cout-param')) {
      var cle = el.getAttribute('data-cout-param');
      return appelApi('POST', { action: 'parametre_enregistrer', cle: cle, valeur: document.getElementById('cp_' + cle).value })
        .then(function () { avis('Paramètre enregistré'); charger(); })
        .catch(function (e) { avis(e.message, 'danger'); });
    }
  });

  document.addEventListener('input', function (ev) {
    if (ev.target && (ev.target.id === 'coutSimTexte' || ev.target.id === 'coutSimJoueurs')) majSimulateur();
  });

  // Bulle d'information au survol / focus des barres du graphique
  function bulle(ev) {
    var col = ev.target.closest && ev.target.closest('.cout-col');
    var b = document.getElementById('coutBulle');
    if (!b) return;
    if (!col) { b.hidden = true; return; }
    var g = col.closest('.cout-graph').getBoundingClientRect(), r = col.getBoundingClientRect();
    b.textContent = col.getAttribute('data-info');
    b.hidden = false;
    var x = r.left - g.left + r.width / 2 - b.offsetWidth / 2;
    b.style.left = Math.max(0, Math.min(x, g.width - b.offsetWidth)) + 'px';
    b.style.top = '-6px';
  }
  document.addEventListener('mouseover', bulle);
  document.addEventListener('focusin', bulle);

  // Charger à l'ouverture de la section (même principe que les autres sections)
  var ancienShowSection = window.showSection;
  window.showSection = function (id, el) {
    if (ancienShowSection) ancienShowSection(id, el);
    if (id === 'couts') charger();
  };

  // Les estimations de SMS ont besoin du taux et du prix : chargement discret pour le superadmin
  window.lbmaChargerCouts = function () {
    if (donnees) return Promise.resolve(donnees);
    return appelApi('GET').then(function (d) { donnees = d; return d; }).catch(function () { return null; });
  };
})();
