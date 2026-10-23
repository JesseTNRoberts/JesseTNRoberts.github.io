#!/usr/bin/env node
// Renders the CV page of a built site to a US Letter PDF.
//
//   node scripts/cv_pdf.js <_site dir> <site url incl. base path> <output.pdf>
//   e.g. node scripts/cv_pdf.js _site https://www.jessetnroberts.com _site/files/Jesse-Roberts-CV.pdf
//
// Requests to the site's own URL are answered from the built _site folder, so the PDF reflects
// this build (not whatever is currently deployed). Uses the page's print styles (_sass/_cv.scss)
// and adds a footer with page numbers. Needs Playwright (require('playwright')).
'use strict';
const fs = require('fs');
const path = require('path');
const { chromium } = require('playwright');

const [siteDir, siteUrlArg, outFile] = process.argv.slice(2);
if (!siteDir || !siteUrlArg || !outFile) {
  console.error('Usage: node scripts/cv_pdf.js <_site dir> <site url> <output.pdf>');
  process.exit(1);
}
const SITE = path.resolve(siteDir);
const siteUrl = siteUrlArg.replace(/\/+$/, '');
const TYPES = { '.html': 'text/html; charset=utf-8', '.css': 'text/css', '.js': 'text/javascript',
  '.svg': 'image/svg+xml', '.png': 'image/png', '.jpg': 'image/jpeg', '.ico': 'image/x-icon',
  '.woff2': 'font/woff2', '.woff': 'font/woff', '.ttf': 'font/ttf', '.json': 'application/json' };

function localFile(url) {
  let rel = decodeURIComponent(new URL(url).pathname);
  const base = new URL(siteUrl + '/').pathname.replace(/\/$/, '');
  if (base && rel.startsWith(base)) rel = rel.slice(base.length);
  let file = path.join(SITE, rel);
  if (!file.startsWith(SITE)) return null;
  if (fs.existsSync(file) && fs.statSync(file).isDirectory()) file = path.join(file, 'index.html');
  else if (!fs.existsSync(file) && fs.existsSync(file + '.html')) file += '.html';
  return fs.existsSync(file) ? file : null;
}

(async () => {
  const browser = await chromium.launch();
  const page = await browser.newPage();
  // Serve the site's own URLs from this build; let everything else (web fonts) load normally.
  await page.route(url => url.href.startsWith(siteUrl) || new URL(url.href).host === new URL(siteUrl).host, route => {
    const file = localFile(route.request().url());
    if (!file) return route.fulfill({ status: 404, body: '' });
    route.fulfill({ status: 200, contentType: TYPES[path.extname(file)] || 'application/octet-stream', body: fs.readFileSync(file) });
  });
  await page.goto(`${siteUrl}/cv/`, { waitUntil: 'networkidle' });
  await page.emulateMedia({ media: 'print' });
  await page.evaluate(() => document.fonts.ready);

  const footer = `
    <div style="width:100%; padding:0 0.7in; font-family:Inter, Arial, sans-serif; font-size:7.5pt; color:#5b636b;
                display:flex; justify-content:space-between;">
      <span>Jesse Roberts · Curriculum Vitae</span>
      <span><span class="pageNumber"></span> / <span class="totalPages"></span></span>
    </div>`;
  fs.mkdirSync(path.dirname(path.resolve(outFile)), { recursive: true });
  await page.pdf({
    path: outFile,
    format: 'Letter',
    printBackground: true,
    displayHeaderFooter: true,
    headerTemplate: '<span></span>',
    footerTemplate: footer,
    margin: { top: '0.6in', bottom: '0.75in', left: '0.7in', right: '0.7in' },
  });
  await browser.close();
  console.log(`Wrote ${outFile} (${(fs.statSync(outFile).size / 1024).toFixed(0)} KB)`);
})().catch(err => { console.error(err); process.exit(1); });
