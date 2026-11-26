import { readdir, readFile, writeFile, cp, mkdir, rm } from 'node:fs/promises';
import { fileURLToPath } from 'node:url';
import path from 'node:path';
import { build } from 'esbuild';
const mobile = fileURLToPath(new URL('../', import.meta.url));
const root = path.resolve(mobile, '..');
const out = path.join(mobile, 'www');
// Explicit public-page list: no administration, login, SQL or server functions.
const pages = `index calendrier stats-classement stats-frappeurs stats-lanceurs equipes
 equipe-profil joueurs carte-joueurs terrains reglements frappeurs-records lanceurs-records
 archives-saisons temple-renommee revue-presse archives-frappeurs archives-lanceurs
 frappeurs-carriere lanceurs-carriere classement-equipes archives contact nous-contacter
 liens-utiles confidentialite stats-match stats-series repechage-live match-live
 stats-live stats-series-live`.split(/\s+/).filter(Boolean).map(n => n + '.html');
await rm(out, { recursive: true, force: true });
await mkdir(out, { recursive: true });
for (const dir of ['assets', 'medias']) await cp(path.join(root, dir), path.join(out, dir), { recursive: true });
for (const name of await readdir(root)) {
  if (/\.(png|jpg|pdf)$/.test(name) || ['lbma-analytics.js', 'manifest.json'].includes(name))
    await cp(path.join(root, name), path.join(out, name));
  if (/\.json$/.test(name) && /^(equipes-|classement-equipes|frappeurs-|lanceurs-)/.test(name))
    await cp(path.join(root, name), path.join(out, name));
}
for (const name of pages) {
  let html = await readFile(path.join(root, name), 'utf8');
  html = html.replace('width=device-width, initial-scale=1.0', 'width=device-width, initial-scale=1.0, viewport-fit=cover');
  // Native bundle supplies offline files itself; do not install the website service worker.
  html = html.replace(/navigator\.serviceWorker\.register\([^;]+;/g, '/* Native bundle: service worker disabled. */');
  html = html.replace('</head>', '<style>body{padding-top:env(safe-area-inset-top)}</style><script defer src="lbma-native.js"></script></head>');
  await writeFile(path.join(out, name), html);
}
await build({ entryPoints: [path.join(mobile, 'src/native.js')], bundle: true, format: 'iife', outfile: path.join(out, 'lbma-native.js'), define: { LBMA_PAGES: JSON.stringify(pages) } });
console.log(`LBMA: ${pages.length} public pages packaged in mobile/www.`);
