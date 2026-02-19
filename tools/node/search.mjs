#!/usr/bin/env node
// search.mjs — Rich component search with formatted output
// Usage: node search.mjs <query> [--category CAT] [--biotools] [--verbose]
import { readFileSync, readdirSync, existsSync } from 'fs';
import { join, resolve } from 'path';
import { componentHeader, chalk } from './lib/display.mjs';

const root = resolve(import.meta.dirname, '../..');
const load = f => JSON.parse(readFileSync(join(root, f), 'utf8'));

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

const compDir = join(root, 'data', 'components');
const compFiles = readdirSync(compDir).filter(f => f.endsWith('.json'));

const biotools = load('data/biotools_mapping.json');
const btMap = {};
for (const m of biotools.mapping) { if (m.matched) btMap[m.component] = m; }

const edam = load('data/edam_mapping.json');
const edMap = {};
for (const m of edam.mapping) { edMap[m.component] = m; }

const iterators = load('data/iterator_catalog.json');

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

console.log(`\n${chalk.bold.cyan(`  Search Results: ${results.length} components`)}\n`);

for (const r of results) {
  const bt = r.bt ? { name: r.bt.tool_name, url: r.bt.bio_tools_url } : null;
  const ed = r.ed ? { operations: r.ed.edam_operations, topics: r.ed.edam_topics } : null;
  console.log(componentHeader(r.name, r.comp.classification, bt, ed));

  if (r.iter) {
    const tmpl = r.iter.iterator_template || 'none';
    console.log(`    ${chalk.yellow('Iterator:')} ${tmpl}`);
  }

  if (verbose) {
    const params = (r.comp.parameters || [])
      .filter(p => !(p.name || p.key || '').match(/^(PIPELINEID|OUTPUT_TOKEN|COMPONENT_NAME|WORKFLOW_REPOSITORY|OUTPUT_DIRECTORY|TMP_DIR|ITERATOR|GROUP_COUNT|NODISTRIB|DOCS_DIR|BIN_DIR|COMPONENT_CONFIG)/))
      .slice(0, 8);
    if (params.length) {
      console.log(`    ${chalk.dim('Parameters:')}`);
      for (const p of params) {
        const name = p.name || p.key || '?';
        const val = p.default || p.value || '';
        console.log(`      ${chalk.dim(name)} = ${chalk.yellow(val || '(empty)')}`);
      }
    }
    const docFile = join(root, 'generated/docs/component_docs', `${r.name}.doc.yaml`);
    if (existsSync(docFile)) console.log(`    ${chalk.dim(`Docs: generated/docs/component_docs/${r.name}.doc.yaml`)}`);
  }
  console.log();
}
