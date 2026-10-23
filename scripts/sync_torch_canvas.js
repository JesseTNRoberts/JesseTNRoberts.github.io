#!/usr/bin/env node
// Syncs the Torch Canvas example library into the site.
//
//   node scripts/sync_torch_canvas.js <path to a torch-canvas checkout>
//
// Reads examples/networks and examples/blocks the same way the app does (library.js), and writes
//   _data/torch_canvas_library.json   one entry per example: id (the ?open= name), title, description,
//                                     kind, blocks used, parameter count, thumbnail path
//   assets/torch-canvas/              the logo and wordmarks, plus a diagram thumbnail per example
//
// Thumbnails and parameter counts come from opening each example in the real app (index.html) in a
// headless browser. That needs Playwright (require('playwright')); without it, the list is still
// written from the files alone and any existing thumbnails are kept.
'use strict';
const fs = require('fs');
const path = require('path');
const http = require('http');
const { execSync } = require('child_process');

const SITE = path.resolve(__dirname, '..');
const SRC = path.resolve(process.argv[2] || '');
const OUT_JSON = path.join(SITE, '_data', 'torch_canvas_library.json');
const ASSETS = path.join(SITE, 'assets', 'torch-canvas');
const THUMBS = path.join(ASSETS, 'thumbs');
const REPO_URL = 'https://github.com/JesseTNRoberts/torch-canvas';

if (!fs.existsSync(path.join(SRC, 'examples'))) {
  console.error(`Not a torch-canvas checkout: ${SRC}`);
  process.exit(1);
}

// ---- read the examples exactly like library.js -------------------------------------------------

// The app's ?open= key: file name without extension and leading "NN_" (src.html: libSlug).
const libBase = f => path.basename(f).replace(/\.\w+$/, '').toLowerCase();
const libSlug = f => libBase(f).replace(/^\d+[_-]/, '');

function readEntry(file, kind) {
  const source = fs.readFileSync(file, 'utf8');
  const ext = path.extname(file).toLowerCase();
  const e = { kind, file: path.relative(path.join(SRC, 'examples'), file).split(path.sep).join('/'), id: libSlug(file) };
  if (ext === '.json') {
    let j;
    try { j = JSON.parse(source); } catch { return null; }
    e.title = j.title; e.description = j.description;
    const blocks = (j.graph && j.graph.blocks) || {};
    e.blocks = Object.values(blocks).map(b => b.name).filter(Boolean);
  } else {
    for (const line of source.split('\n')) {
      const m = /^#\s*(title|description)\s*:\s*(.*)$/i.exec(line);
      if (m) e[m[1].toLowerCase()] = m[2].trim();
      else if (line.trim() && !line.startsWith('#')) break;
    }
    e.blocks = [];
  }
  e.title = e.title || libBase(file).replace(/^\d+_/, '').replace(/_/g, ' ');
  e.description = e.description || '';
  return e;
}

function scan() {
  const out = { networks: [], blocks: [] };
  for (const [dir, kind] of [['networks', 'network'], ['blocks', 'block']]) {
    const full = path.join(SRC, 'examples', dir);
    if (!fs.existsSync(full)) continue;
    for (const f of fs.readdirSync(full).sort()) {
      if (!/\.(py|json)$/i.test(f)) continue;
      if (kind === 'network' && f.startsWith('_')) continue; // hidden in the app too
      const e = readEntry(path.join(full, f), kind);
      if (e) out[dir].push(e);
    }
  }
  return out;
}

// ---- render thumbnails and read parameter counts from the real app ------------------------------

function serve(dir) {
  const types = { '.html': 'text/html; charset=utf-8', '.js': 'text/javascript; charset=utf-8', '.json': 'application/json; charset=utf-8', '.svg': 'image/svg+xml' };
  const server = http.createServer((req, res) => {
    const p = path.join(dir, decodeURIComponent(new URL(req.url, 'http://x').pathname));
    if (!p.startsWith(dir) || !fs.existsSync(p) || fs.statSync(p).isDirectory()) { res.writeHead(404); return res.end(); }
    res.writeHead(200, { 'Content-Type': types[path.extname(p)] || 'application/octet-stream' });
    fs.createReadStream(p).pipe(res);
  });
  return new Promise(r => server.listen(0, '127.0.0.1', () => r(server)));
}

async function render(entries) {
  let chromium;
  try { ({ chromium } = require('playwright')); } catch {
    console.warn('Playwright not available: skipping thumbnails and parameter counts.');
    return;
  }
  fs.mkdirSync(THUMBS, { recursive: true });
  const server = await serve(SRC);
  const base = `http://127.0.0.1:${server.address().port}/index.html`;
  const browser = await chromium.launch();
  try {
    for (const e of entries) {
      // a fresh context per example, so no tabs carry over from the last one
      const ctx = await browser.newContext({ viewport: { width: 1100, height: 720 }, deviceScaleFactor: 1 });
      const page = await ctx.newPage();
      try {
        await page.goto(`${base}?open=${encodeURIComponent(e.id)}`, { waitUntil: 'load' });
        await page.waitForTimeout(1500);
        const chip = await page.$('#paramChip');
        const params = chip ? (await chip.textContent()).trim() : '';
        if (/params/.test(params)) e.params = params.replace(/\s*params$/, '');
        // show just the diagram: hide the side panels and chrome, then fit the view
        await page.addStyleTag({ content: `
          .main > aside, .main > .right, header, .tabstrip, .canvas-ctl, .legend, .blockbar, .drawer,
          .var-float, .empty-msg, .toast, #toast { display: none !important; }
          .main { grid-template-columns: 1fr !important; }` });
        await page.waitForTimeout(200);
        await page.keyboard.press('f');
        await page.waitForTimeout(500);
        const wrap = await page.$('#wrap');
        const file = path.join(THUMBS, `${e.id}.png`);
        await wrap.screenshot({ path: file });
        e.thumb = `/assets/torch-canvas/thumbs/${e.id}.png`;
        console.log(`  ${e.kind} ${e.id}: ${e.params || '?'} params`);
      } catch (err) {
        console.warn(`  ${e.id}: couldn't render (${err.message.split('\n')[0]})`);
      }
      await ctx.close();
    }
  } finally {
    await browser.close();
    server.close();
  }
}

(async () => {
  const lib = scan();
  const all = [...lib.networks, ...lib.blocks];
  console.log(`Found ${lib.networks.length} networks and ${lib.blocks.length} blocks.`);

  // keep last run's thumbnails / params if rendering isn't possible this time
  let previous = {};
  try { for (const e of [...(JSON.parse(fs.readFileSync(OUT_JSON, 'utf8')).networks || []), ...(JSON.parse(fs.readFileSync(OUT_JSON, 'utf8')).blocks || [])]) previous[e.id] = e; } catch {}
  for (const e of all) { const p = previous[e.id]; if (p) { if (p.params) e.params = p.params; if (p.thumb && fs.existsSync(path.join(SITE, p.thumb))) e.thumb = p.thumb; } }

  if (fs.existsSync(path.join(SRC, 'index.html'))) await render(all);

  fs.mkdirSync(ASSETS, { recursive: true });
  for (const f of ['logo.svg', 'wordmark-light.svg', 'wordmark-dark.svg']) {
    const p = path.join(SRC, 'assets', f);
    if (fs.existsSync(p)) fs.copyFileSync(p, path.join(ASSETS, f));
  }

  let commit = '';
  try { commit = execSync('git rev-parse HEAD', { cwd: SRC }).toString().trim(); } catch {}
  const data = { source: REPO_URL, commit, updated: new Date().toISOString(), networks: lib.networks, blocks: lib.blocks };
  fs.writeFileSync(OUT_JSON, JSON.stringify(data, null, 2) + '\n');
  console.log(`Wrote ${path.relative(SITE, OUT_JSON)}`);
})();
