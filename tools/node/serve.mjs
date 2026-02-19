#!/usr/bin/env node
// serve.mjs — Serve the EELS viewer and data
import { createServer } from 'http';
import { readFile } from 'fs/promises';
import { join, extname, resolve } from 'path';

const root = resolve(import.meta.dirname, '..');
const port = parseInt(process.argv[2] || '8080');

const mime = {
  '.html': 'text/html', '.js': 'text/javascript', '.mjs': 'text/javascript',
  '.css': 'text/css', '.json': 'application/json', '.svg': 'image/svg+xml',
  '.png': 'image/png', '.ico': 'image/x-icon',
};

createServer(async (req, res) => {
  let url = req.url.split('?')[0];
  if (url === '/') url = '/viewer/index.html';

  const file = join(root, url);
  // Only serve viewer/ and data/ directories
  if (!file.startsWith(join(root, 'viewer')) && !file.startsWith(join(root, 'data'))) {
    res.writeHead(403); res.end(); return;
  }

  try {
    const data = await readFile(file);
    res.writeHead(200, { 'Content-Type': mime[extname(file)] || 'application/octet-stream' });
    res.end(data);
  } catch {
    res.writeHead(404); res.end('Not found');
  }
}).listen(port, () => {
  console.log(`EELS viewer: http://localhost:${port}`);
});
