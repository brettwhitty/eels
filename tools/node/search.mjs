#!/usr/bin/env node
// search.mjs — Rich component search with formatted output
// Usage: node search.mjs <query> [--category CAT] [--biotools] [--verbose]
import { readFileSync, readdirSync, existsSync } from 'fs';
import { join, resolve } from 'path';

const root = resolve(import.meta.dirname, '../..');
const load = f => JSON.parse(readFileSync(join(root, f), 'utf8'));

const c = {
  reset: '\x1b[0m', bold: '\x1b[1m', dim: '\x1b[2m',
  red: '\x1b[31m', green: '\x1b[32m', yellow: '\x1b[33m',
  blue: '\x1b[34m', magenta: '\x1b[35m', cyan: '\x1b[36m',
};

const args = process.argv.slice(2);
const verbose = args.includes('--verbose') || args.includes('-v');
const btOnly = args.includes('--biotools');
let catFilter = null;
const catIdx = args.indexOf('--category');
if (catIdx >= 0) { catFilter = args[catIdx + 1]?.toLowerCase(); args.splice(catIdx, 2); }
const query = args.filter(a => !a.startsWith('-'))[0]?.toLowerCase();

if (!query && !catFilter && !btOnly) {
  console.log(`\n  Usage: node search.mjs <query> [--category CAT] [--biotools] [--verbose]\n`);
  console.log(`  Examples:`);
  console.log(`    node search.mjs blast`);
  console.log(`    node search.mjs --category "RNA-Seq" --verbose`);
  console.log(`    node search.mjs hmm --biotools\n`);
  process.exit(0);
}

// Load data
const compDir = join(root, 'data', 'components');
const compFiles = readdirSync(compDir).filter(f => f.endsWith('.json'));

const biotools = load('data/biotools_mapping.json');
const btMap = {};
for (const m of biotools.mapping) { if (m.matched) btMap[m.component] = m; }

const edam = load('data/edam_mapping.json');
const edMap = {};
for (const m of edam.mapping) { edMap[m.component] = m; }

const iterators = load('data/iterator_catalog.json');

// Search
const results = [];
for (const f of compFiles) {
  const name = f.replace('.json', '');
  const comp = JSON.parse(readFileSync(join(compDir, f), 'utf8'));
  const cls = (comp.classification || '').toLowerCase();

  let match = true;
  if (query && !(name.toLowerCase().includes(query) || cls.includes(query))) match = false;
  if (catFilter && !cls.includes(catFilter)) match = false;
  if (btOnly && !btMap[name]) match = false;
  if (!query && !catFilter && !btOnly) match = false;

  if (match) results.push({ name, comp, bt: btMap[name], ed: edMap[name], iter: iterators[name] });
}

results.sort((a, b) => a.name.localeCompare(b.name));

console.log(`\n${c.bold}${c.cyan}  Search Results: ${results.length} components${c.reset}\n`);

for (const r of results) {
  const cls = r.comp.classification || 'unclassified';
  console.log(`  ${c.bold}${c.green}${r.name}${c.reset} ${c.dim}— ${cls}${c.reset}`);

  if (r.bt) {
    console.log(`    ${c.blue}bio.tools:${c.reset} ${r.bt.tool_name} ${c.dim}(${r.bt.bio_tools_url})${c.reset}`);
  }
  if (r.ed) {
    if (r.ed.edam_operations?.length) console.log(`    ${c.magenta}EDAM ops:${c.reset} ${r.ed.edam_operations.join(', ')}`);
    if (r.ed.edam_topics?.length) console.log(`    ${c.magenta}EDAM topics:${c.reset} ${r.ed.edam_topics.join(', ')}`);
  }
  if (r.iter) {
    const tmpl = r.iter.iterator_template || 'none';
    console.log(`    ${c.yellow}Iterator:${c.reset} ${tmpl}`);
  }

  if (verbose) {
    const params = (r.comp.parameters || [])
      .filter(p => !(p.name || p.key || '').match(/^(PIPELINEID|OUTPUT_TOKEN|COMPONENT_NAME|WORKFLOW_REPOSITORY|OUTPUT_DIRECTORY|TMP_DIR|ITERATOR|GROUP_COUNT|NODISTRIB|DOCS_DIR|BIN_DIR|COMPONENT_CONFIG)/))
      .slice(0, 8);
    if (params.length) {
      console.log(`    ${c.dim}Parameters:${c.reset}`);
      for (const p of params) {
        const name = p.name || p.key || '?';
        const val = p.default || p.value || '';
        console.log(`      ${c.dim}${name}${c.reset} = ${c.yellow}${val || '(empty)'}${c.reset}`);
      }
    }

    // Check for doc yaml
    const docFile = join(root, 'generated/docs/component_docs', `${r.name}.doc.yaml`);
    if (existsSync(docFile)) {
      console.log(`    ${c.dim}Docs: generated/docs/component_docs/${r.name}.doc.yaml${c.reset}`);
    }
  }
  console.log();
}
