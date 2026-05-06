// LBMA Service Worker — v1.0
const CACHE_NAME = 'lbma-v1';

// Fichiers à mettre en cache pour fonctionnement hors-ligne
const STATIC_ASSETS = [
  '/',
  '/index.html',
  '/calendrier.html',
  '/classements.html',
  '/stats-frappeurs.html',
  '/stats-lanceurs.html',
  '/logo-lbma.jpg',
  '/apple-touch-icon.png',
  '/icon-192.png',
  '/icon-512.png',
  '/assets/js/lbma-utils.js',
  'https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Oswald:wght@400;600;700&family=Work+Sans:wght@300;400;600;700&display=swap'
];

// Installation — mise en cache des assets statiques
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME).then(cache => {
      return cache.addAll(STATIC_ASSETS);
    })
  );
  self.skipWaiting();
});

// Activation — suppression des anciens caches
self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(keys =>
      Promise.all(keys.filter(k => k !== CACHE_NAME).map(k => caches.delete(k)))
    )
  );
  self.clients.claim();
});

// Fetch — stratégie : Network First (données fraîches), Cache comme fallback
self.addEventListener('fetch', event => {
  const url = new URL(event.request.url);

  // Requêtes Supabase — toujours réseau (jamais cache)
  if (url.hostname.includes('supabase.co')) return;

  // Requêtes POST (formulaires, API) — toujours réseau
  if (event.request.method !== 'GET') return;

  event.respondWith(
    fetch(event.request)
      .then(response => {
        // Mettre à jour le cache avec la réponse fraîche
        const clone = response.clone();
        caches.open(CACHE_NAME).then(cache => cache.put(event.request, clone));
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
