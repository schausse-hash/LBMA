// scripts/verifier.mjs — Vérification automatique du site LBMA
// Lancée par GitHub à chaque PR (.github/workflows/verification.yml),
// et à la main avec :  node scripts/verifier.mjs
//
// Ce qu'elle vérifie (sans rien installer) :
//   1. la syntaxe de chaque fichier JavaScript (api/, assets/js/, racine)
//   2. la syntaxe de chaque <script> écrit directement dans les pages HTML
//   3. que chaque fichier .json se lit sans erreur
//   4. qu'aucune clé secrète n'a été collée dans le code
import { readFileSync, readdirSync, statSync, writeFileSync, mkdtempSync } from 'node:fs';
import { join, extname, relative } from 'node:path';
import { tmpdir } from 'node:os';
import { spawnSync } from 'node:child_process';

const RACINE = process.cwd();
const IGNORER = new Set(['.git', 'node_modules', 'medias', '.vercel']);
const tmp = mkdtempSync(join(tmpdir(), 'lbma-verif-'));
const erreurs = [];
let nbVerifs = 0;

function fichiers(dossier) {
  const out = [];
  for (const nom of readdirSync(dossier)) {
    if (IGNORER.has(nom)) continue;
    const chemin = join(dossier, nom);
    if (statSync(chemin).isDirectory()) out.push(...fichiers(chemin));
    else out.push(chemin);
  }
  return out;
}

function nodeCheck(chemin, etiquette, decalageLigne = 0) {
  nbVerifs++;
  const r = spawnSync(process.execPath, ['--check', chemin], { encoding: 'utf8' });
  if (r.status !== 0) {
    let msg = (r.stderr || '').trim().split('\n');
    // Remplacer « fichier:ligne » du fichier temporaire par la vraie ligne dans la page
    const m = msg[0] && msg[0].match(/:(\d+)$/);
    const ligne = m ? parseInt(m[1], 10) + decalageLigne : null;
    const detail = msg.find(l => /Error/.test(l)) || msg[msg.length - 1];
    erreurs.push(`${etiquette}${ligne ? ':' + ligne : ''} — ${detail}`);
  }
}

// Motifs de clés qui ne doivent JAMAIS être dans le dépôt (il est public)
const SECRETS = [
  { nom: 'clé Resend', re: /\bre_[A-Za-z0-9]{8,}_[A-Za-z0-9]{16,}\b/ },
  { nom: 'jeton Twilio (Account SID + Auth Token)', re: /\bAC[0-9a-f]{32}\b/ },
  { nom: 'clé privée', re: /-----BEGIN [A-Z ]*PRIVATE KEY-----/ },
  { nom: 'jeton GitHub', re: /\bgh[pousr]_[A-Za-z0-9]{36,}\b/ },
  { nom: 'clé Supabase sb_secret', re: /\bsb_secret_[A-Za-z0-9_-]{20,}\b/ }
];
function jwtServiceRole(texte) {
  const jwts = texte.match(/eyJ[A-Za-z0-9_-]{10,}\.eyJ[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}/g) || [];
  return jwts.some(t => {
    try { return JSON.parse(Buffer.from(t.split('.')[1], 'base64url').toString()).role === 'service_role'; }
    catch { return false; }
  });
}

for (const chemin of fichiers(RACINE)) {
  const rel = relative(RACINE, chemin).replace(/\\/g, '/');
  const ext = extname(chemin).toLowerCase();
  if (!['.js', '.mjs', '.html', '.json', '.sql', '.md', '.txt'].includes(ext)) continue;
  const texte = readFileSync(chemin, 'utf8');

  // 4. Secrets
  for (const s of SECRETS) if (s.re.test(texte)) erreurs.push(`${rel} — contient ce qui ressemble à une ${s.nom}`);
  if (jwtServiceRole(texte)) erreurs.push(`${rel} — contient une clé Supabase service_role (elle donne TOUS les droits sur la base)`);

  // 1. Fichiers JavaScript
  if (ext === '.js' || ext === '.mjs') nodeCheck(chemin, rel);

  // 2. Scripts dans les pages HTML
  if (ext === '.html') {
    // Retirer les commentaires HTML (en gardant les sauts de ligne pour les numéros de ligne) :
    // un commentaire comme <!-- à mettre dans <script> --> ne doit pas compter comme un script
    const page = texte.replace(/<!--[\s\S]*?-->/g, c => c.replace(/[^\n]/g, ' '));
    const re = /<script\b([^>]*)>([\s\S]*?)<\/script>/gi;
    let m, n = 0;
    while ((m = re.exec(page))) {
      const attrs = m[1], code = m[2];
      if (/\bsrc\s*=/.test(attrs) || !code.trim()) continue;
      const type = (attrs.match(/\btype\s*=\s*["']?([^"'\s>]+)/i) || [])[1] || '';
      if (type && !/^(text\/javascript|module|application\/javascript)$/i.test(type)) continue; // JSON-LD, gabarits…
      const ligneDebut = page.slice(0, m.index + m[0].indexOf('>') + 1).split('\n').length - 1;
      const tmpFichier = join(tmp, `${rel.replace(/[\/.]/g, '_')}_${n++}${type === 'module' ? '.mjs' : '.js'}`);
      writeFileSync(tmpFichier, code);
      nodeCheck(tmpFichier, rel, ligneDebut);
    }
  }

  // 3. JSON
  if (ext === '.json') {
    nbVerifs++;
    try { JSON.parse(texte); } catch (e) { erreurs.push(`${rel} — JSON invalide : ${e.message}`); }
  }
}

if (erreurs.length) {
  console.error(`❌ ${erreurs.length} problème(s) trouvé(s) :\n`);
  erreurs.forEach(e => console.error('  • ' + e));
  console.error('\nCorrige ces erreurs avant de fusionner la PR.');
  process.exit(1);
}
console.log(`✅ Tout est beau : ${nbVerifs} vérifications réussies.`);
