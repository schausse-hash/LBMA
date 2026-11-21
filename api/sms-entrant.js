// api/sms-entrant.js — Réponses des joueurs aux SMS de la ligue
//
// Twilio appelle cette adresse quand quelqu'un écrit au numéro de la LBMA
// (réglage dans Twilio : Phone Numbers → le numéro → Messaging configuration →
//  « A message comes in » = Webhook, https://www.liguelbma.org/api/sms-entrant, HTTP POST).
//
// Ce que la fonction fait :
//   1. vérifie que l'appel vient vraiment de Twilio (signature X-Twilio-Signature)
//   2. retrouve le joueur d'après son numéro de téléphone
//   3. transfère le message par courriel (Resend) à l'adresse SMS_REPONSES_COURRIEL
//   4. inscrit la réponse dans journal_envois (page Coûts du site)
//   5. répond à Twilio « ne rien renvoyer » : le joueur ne reçoit aucun message automatique
//
// Variables Vercel : TWILIO_AUTH_TOKEN, RESEND_API_KEY, SUPABASE_URL,
// SUPABASE_SERVICE_ROLE_KEY, SMS_REPONSES_COURRIEL (une ou plusieurs adresses, séparées par des virgules)

import crypto from 'node:crypto';

const ADRESSE_PUBLIQUE = 'https://www.liguelbma.org/api/sms-entrant';
const REPONSE_VIDE = '<?xml version="1.0" encoding="UTF-8"?><Response></Response>';

// Signature Twilio : HMAC-SHA1 (clé = Auth Token) de l'adresse appelée suivie de
// chaque paramètre reçu, triés par nom, collés « nomvaleur ». Résultat en base64.
export function signatureTwilio(jeton, adresse, params) {
    const donnees = Object.keys(params).sort().reduce((acc, k) => acc + k + params[k], adresse);
    return crypto.createHmac('sha1', jeton).update(Buffer.from(donnees, 'utf-8')).digest('base64');
}

function egal(a, b) {
    const x = Buffer.from(String(a || '')), y = Buffer.from(String(b || ''));
    return x.length === y.length && crypto.timingSafeEqual(x, y);
}

function lireParametres(req) {
    if (req.body && typeof req.body === 'object') return req.body;
    if (typeof req.body === 'string') return Object.fromEntries(new URLSearchParams(req.body));
    return {};
}

function esc(v) {
    return String(v == null ? '' : v).replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));
}

function chiffres(tel) {
    const d = String(tel || '').replace(/\D/g, '');
    return d.length === 11 && d[0] === '1' ? d.slice(1) : d;
}

function telLisible(tel) {
    const d = chiffres(tel);
    return d.length === 10 ? `(${d.slice(0, 3)}) ${d.slice(3, 6)}-${d.slice(6)}` : String(tel || '');
}

async function sb(path, options = {}) {
    const cle = process.env.SUPABASE_SERVICE_ROLE_KEY;
    return fetch(process.env.SUPABASE_URL + '/rest/v1/' + path, {
        ...options,
        headers: { apikey: cle, Authorization: 'Bearer ' + cle, 'Content-Type': 'application/json', ...(options.headers || {}) }
    });
}

// Retrouver le joueur (saison active d'abord, sinon la plus récente où ce numéro apparaît)
async function trouverJoueur(de) {
    const cible = chiffres(de);
    if (cible.length !== 10) return null;
    try {
        const r = await sb('joueurs_liste?or=(telephone1.not.is.null,telephone2.not.is.null,telephone.not.is.null)&select=nom,saison,telephone1,telephone2,telephone&order=saison.desc&limit=5000');
        if (!r.ok) return null;
        const joueurs = await r.json();
        return joueurs.find(j => [j.telephone1, j.telephone2, j.telephone].some(t => chiffres(t) === cible)) || null;
    } catch (e) { return null; }
}

export default async function handler(req, res) {
    res.setHeader('Content-Type', 'text/xml');
    if (req.method !== 'POST') return res.status(405).send(REPONSE_VIDE);

    const JETON = process.env.TWILIO_AUTH_TOKEN;
    if (!JETON) { console.error('sms-entrant : TWILIO_AUTH_TOKEN manquant'); return res.status(500).send(REPONSE_VIDE); }

    // 1. Signature — on accepte l'adresse publique et l'adresse réellement appelée
    const params = lireParametres(req);
    const recue = req.headers['x-twilio-signature'];
    const hote = req.headers['x-forwarded-host'] || req.headers.host;
    const adresses = [ADRESSE_PUBLIQUE];
    if (hote) adresses.push('https://' + hote + req.url);
    if (!adresses.some(a => egal(signatureTwilio(JETON, a, params), recue))) {
        console.warn('sms-entrant : signature Twilio invalide — appel refusé');
        return res.status(403).send(REPONSE_VIDE);
    }

    const de = params.From || '';
    const texte = String(params.Body || '').trim();
    const segments = parseInt(params.NumSegments, 10) || 1;
    const medias = parseInt(params.NumMedia, 10) || 0;
    const motCle = texte.toUpperCase();
    const desabonnement = ['STOP', 'ARRET', 'ARRÊT', 'UNSUBSCRIBE', 'CANCEL', 'END', 'QUIT', 'STOPALL'].includes(motCle);
    const reabonnement = ['START', 'UNSTOP', 'YES'].includes(motCle);

    // 2. Qui écrit ?
    const joueur = await trouverJoueur(de);
    const nom = joueur ? joueur.nom : null;

    // 3. Courriel
    const destinataires = String(process.env.SMS_REPONSES_COURRIEL || '').split(',').map(s => s.trim()).filter(s => s.includes('@'));
    let courrielOk = false;
    if (!destinataires.length) {
        console.error('sms-entrant : SMS_REPONSES_COURRIEL manquant — réponse non transférée');
    } else if (!process.env.RESEND_API_KEY) {
        console.error('sms-entrant : RESEND_API_KEY manquant');
    } else {
        const qui = nom ? `${nom} (${telLisible(de)})` : telLisible(de);
        const sujet = desabonnement ? `SMS LBMA — ${qui} s'est désabonné (STOP)`
            : reabonnement ? `SMS LBMA — ${qui} s'est réabonné`
            : `SMS LBMA — réponse de ${qui}`;
        const html = `
            <div style="font-family:Arial,sans-serif;max-width:600px;color:#333">
                <div style="background:#1E3A5F;color:#fff;padding:1rem 1.25rem;font-weight:bold">Réponse à un SMS de la LBMA</div>
                <div style="padding:1.25rem;border:1px solid #ddd;border-top:0">
                    <p style="margin:0 0 .5rem"><strong>De :</strong> ${esc(qui)}${joueur ? ` — joueur ${esc(joueur.saison)}` : ' — numéro inconnu dans la liste des joueurs'}</p>
                    <p style="margin:0 0 1rem"><strong>Reçu :</strong> ${esc(new Date().toLocaleString('fr-CA', { timeZone: 'America/Toronto', dateStyle: 'long', timeStyle: 'short' }))}</p>
                    <div style="background:#f5f1e8;border-left:4px solid #D4AF37;padding:.75rem 1rem;white-space:pre-wrap;font-size:15px">${esc(texte) || '<em>(message vide)</em>'}</div>
                    ${medias ? `<p style="color:#888;font-size:13px">+ ${medias} image(s) jointe(s), visible(s) dans la console Twilio.</p>` : ''}
                    ${desabonnement ? '<p style="color:#b00;font-size:13px">Twilio a automatiquement retiré ce numéro : il ne recevra plus les SMS de la ligue tant qu\'il n\'aura pas répondu START.</p>' : ''}
                    <p style="color:#888;font-size:12px;margin-top:1.25rem">Pour lui répondre, écris-lui directement de ton téléphone : le numéro de la ligue ne transmet pas les réponses envoyées par courriel.</p>
                </div>
            </div>`;
        try {
            const r = await fetch('https://api.resend.com/emails', {
                method: 'POST',
                headers: { Authorization: 'Bearer ' + process.env.RESEND_API_KEY, 'Content-Type': 'application/json' },
                body: JSON.stringify({ from: 'LBMA <noreply@liguelbma.org>', to: destinataires, subject: sujet, html })
            });
            courrielOk = r.ok;
            if (!r.ok) console.error('sms-entrant : erreur Resend', r.status, await r.text());
        } catch (e) { console.error('sms-entrant : Resend', e.message); }
    }

    // 4. Journal (coût d'un SMS reçu : même prix par segment qu'un envoi)
    try {
        await sb('journal_envois', {
            method: 'POST',
            headers: { Prefer: 'return=minimal' },
            body: JSON.stringify({
                canal: 'sms', type_envoi: 'sms_reponse',
                nb_destinataires: 1, nb_reussis: courrielOk ? 1 : 0, nb_echecs: courrielOk ? 0 : 1,
                segments, cout_estime_usd: +(segments * 0.0079).toFixed(4), simulation: false,
                demande_par: nom || telLisible(de),
                sujet: desabonnement ? 'Réponse reçue : STOP (désabonnement)' : 'Réponse reçue d\'un joueur'
            })
        });
    } catch (e) { console.error('journal_envois :', e.message); }

    // 5. Ne rien renvoyer au joueur
    return res.status(200).send(REPONSE_VIDE);
}
