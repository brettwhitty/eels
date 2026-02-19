#!/usr/bin/env node
// build.mjs — Build viewer/index.html with all data inlined
// Output is a single self-contained HTML file that works from file:// or GitHub Pages
import { readFileSync, writeFileSync, readdirSync } from 'fs';
import { join, resolve } from 'path';

const root = resolve(import.meta.dirname, '..');
const load = f => { try { return JSON.parse(readFileSync(join(root, f), 'utf8')); } catch { return null; } };
const loadDir = d => {
  const out = {};
  for (const f of readdirSync(join(root, d)).filter(f => f.endsWith('.json'))) {
    out[f.replace('.json', '')] = JSON.parse(readFileSync(join(root, d, f), 'utf8'));
  }
  return out;
};

const data = {
  components: loadDir('data/components'),
  steps: loadDir('data/categorized_steps'),
  pipelines: loadDir('data/pipelines'),
  resourceMap: (load('data/resource_map.json') || {}).resources || [],
  resourceSummary: (load('data/resource_map.json') || {}).summary || {},
  toolCatalog: load('data/tool_catalog_full.json') || [],
  naming: load('data/naming_conventions.json') || {},
  biotools: {},
  edam: {},
};

const bt = load('data/biotools_mapping.json');
if (bt?.mapping) for (const m of bt.mapping) {
  if (m.matched) data.biotools[m.component] = { id: m.biotoolsID, name: m.tool_name };
}
const ed = load('data/edam_mapping.json');
if (ed?.mapping) for (const m of ed.mapping) {
  data.edam[m.component] = { operations: m.edam_operations || [], topics: m.edam_topics || [] };
}

const template = readFileSync(join(import.meta.dirname, 'app.html'), 'utf8');
const d3src = readFileSync(join(root, 'node_modules', 'd3', 'dist', 'd3.min.js'), 'utf8');
let html = template;

// Replace D3 CDN with inlined source (substring to avoid $ replacement issues)
const cdnTag = '<script src="https://d3js.org/d3.v7.min.js"></script>';
let idx = html.indexOf(cdnTag);
html = html.substring(0, idx) + '<script>\n' + d3src + '\n</script>' + html.substring(idx + cdnTag.length);

// Inline data — use split/join to avoid $ replacement issues
const parts = html.split('/*__EELS_DATA__*/');
html = parts[0] + 'const D = ' + JSON.stringify(data) + ';' + parts[1];

writeFileSync(join(import.meta.dirname, 'index.html'), html);
const size = (Buffer.byteLength(html) / 1024 / 1024).toFixed(1);
console.log(`Built viewer/index.html: ${size} MB (${Object.keys(data.components).length} components, ${Object.keys(data.pipelines).length} pipelines, ${data.resourceMap.length} resources)`);
