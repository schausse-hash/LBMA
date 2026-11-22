import { Capacitor } from '@capacitor/core';
import { App } from '@capacitor/app';
import { Browser } from '@capacitor/browser';
if (Capacitor.isNativePlatform()) {
  const pages = new Set(LBMA_PAGES);
  document.addEventListener('click', async event => {
    const link = event.target.closest('a[href]');
    if (!link || event.defaultPrevented) return;
    const url = new URL(link.href, location.href);
    if (['mailto:', 'tel:'].includes(url.protocol)) return;
    if (!['https:', 'http:'].includes(url.protocol)) { event.preventDefault(); return; }
    const local = url.origin === location.origin;
    const name = url.pathname.split('/').pop() || 'index.html';
    if (local && (pages.has(name) || url.hash && url.pathname === location.pathname)) return;
    event.preventDefault();
    if (local) {
      url.protocol = 'https:';
      url.host = 'www.liguelbma.org';
      url.port = '';
    }
    try { await Browser.open({ url: url.href }); }
    catch { alert('Impossible d’ouvrir ce lien. Vérifiez votre connexion Internet.'); }
  });
  App.addListener('backButton', ({ canGoBack }) => {
    const panel = document.getElementById('lbma-nav-root');
    const expanded = panel?.querySelector('button[aria-expanded="true"]');
    if (expanded) expanded.click();
    else if (canGoBack) history.back();
    else if (!location.pathname.endsWith('/index.html') && location.pathname !== '/') location.href = 'index.html';
    else App.minimizeApp();
  });
}
