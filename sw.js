// LBMA Service Worker — v2.0
// v2 : installation tolerante aux echecs (un fichier manquant ne bloque plus
// jamais l'installation — c'est ce qui empechait les mises a jour du SW),
// nouveau nom de cache pour purger les anciens caches corrompus.
const CACHE_NAME = 'lbma-v2';

// Fichiers à mettre en cache pour fonctionnement hors-ligne
const STATIC_ASSETS = [
  '/',
  '/index.html',
  '/calendrier.html',
  '/classement-equipes.html',
  '/stats-frappeurs.html',
  '/stats-lanceurs.html',
  '/logo-lbma.jpg',
  '/apple-touch-icon.png',
  '/icon-192.png',
  '/icon-512.png',
  '/assets/js/lbma-utils.js'
];

// Installation — mise en cache des assets statiques, un par un :
// un echec individuel (404, reseau) n'empeche JAMAIS l'installation.
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME).then(cache =>
      Promise.allSettled(STATIC_ASSETS.map(url => cache.add(url)))
    )
  );
  self.skipWaiting();
});

// Activation — suppression des anciens caches + prise de controle immediate
self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(keys =>
      Promise.all(keys.filter(k => k !== CACHE_NAME).map(k => caches.delete(k)))
    ).then(() => self.clients.claim())
  );
});

// Fetch — stratégie : Network First (données fraîches), Cache comme fallback
self.addEventListener('fetch', event => {
  const url = new URL(event.request.url);

  // Requêtes Supabase — toujours réseau (jamais cache)
  if (url.hostname.includes('supabase.co')) return;

  // Requêtes POST (formulaires, API) — toujours réseau
  if (event.request.method !== 'GET') return;

  // Autres origines (fonts, CDN) — laisser le navigateur gérer
  if (url.origin !== self.location.origin) return;

  event.respondWith(
    fetch(event.request)
      .then(response => {
        // Mettre à jour le cache avec la réponse fraîche
        if (response.ok) {
          const clone = response.clone();
          caches.open(CACHE_NAME).then(cache => cache.put(event.request, clone));
        }
        return response;
      })
      .catch(() => {
        // Hors-ligne : retourner depuis le cache
        return caches.match(event.request).then(cached => {
          return cached || caches.match('/index.html');
        });
      })
  );
});
