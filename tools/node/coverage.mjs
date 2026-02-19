#!/usr/bin/env node
// coverage.mjs — Coverage/mapping report across all registry and documentation sources
import { readFileSync, readdirSync } from 'fs';
import { join, resolve } from 'path';

const root = resolve(import.meta.dirname, '../..');
const load = f => JSON.parse(readFileSync(join(root, f), 'utf8'));
const count = (dir, ext) => {
  try { return new Set(readdirSync(join(root, dir)).filter(f => f.endsWith(ext)).map(f => f.replace(ext, ''))); }
  catch { return new Set(); }
};

const c = {
  reset: '\x1b[0m', bold: '\x1b[1m', dim: '\x1b[2m',
  red: '\x1b[31m', green: '\x1b[32m', yellow: '\x1b[33m',
  blue: '\x1b[34m', cyan: '\x1b[36m',
};

const bar = (n, max, w = 40) => {
  const filled = Math.round((n / max) * w);
  return '█'.repeat(filled) + '░'.repeat(w - filled);
};

const compNames = count('data/components', '.json');
const total = compNames.size;

// Gather coverage sets
const docYamls = count('generated/docs/component_docs', '.doc.yaml');
// Fix: doc yamls use .doc.yaml suffix
const docSet = new Set(readdirSync(join(root, 'generated/docs/component_docs'))
  .filter(f => f.endsWith('.doc.yaml'))
  .map(f => f.replace('.doc.yaml', '')));

const cwlSet = count('generated/wfl-lang/cwl/components', '.cwl');
const nfSet = count('generated/wfl-lang/nextflow/components', '.nf');
const liteSet = count('generated/wfl-lang/ergatis_lite/components', '.lite');
const bcoSet = count('generated/docs/bco/components', '.json');

const biotools = load('data/biotools_mapping.json');
const btSet = new Set(biotools.mapping.filter(m => m.matched).map(m => m.component));

const edam = load('data/edam_mapping.json');
const edSet = new Set(edam.mapping.map(m => m.component));

const iterators = load('data/iterator_catalog.json');
const itSet = new Set(Object.keys(iterators));

const stepSet = count('data/categorized_steps', '.json');

// Report
const sources = [
  ['Categorized Steps', stepSet],
  ['Documentation YAML', docSet],
  ['CWL Definitions', cwlSet],
  ['Nextflow Processes', nfSet],
  ['Ergatis Lite', liteSet],
  ['BioCompute Objects', bcoSet],
  ['bio.tools Mapping', btSet],
  ['EDAM Mapping', edSet],
  ['Iterator Defined', itSet],
];

console.log(`\n${c.bold}${c.cyan}  EELS Coverage Report${c.reset}`);
console.log(`${c.dim}  Coverage of ${total} extracted components across all artifact types${c.reset}\n`);

for (const [label, set] of sources) {
  const n = [...set].filter(s => compNames.has(s)).length;
  const pct = Math.round(n / total * 100);
  const color = pct >= 90 ? c.green : pct >= 50 ? c.yellow : c.red;
  console.log(`  ${label.padEnd(22)} ${color}${bar(n, total)}${c.reset} ${String(n).padStart(4)}/${total} ${c.dim}(${pct}%)${c.reset}`);
}

// Find components missing from key artifacts
console.log(`\n${c.bold}${c.cyan}  Gap Analysis${c.reset}\n`);

const missingBt = [...compNames].filter(n => !btSet.has(n)).sort();
const missingEdam = [...compNames].filter(n => !edSet.has(n)).sort();
const missingIter = [...compNames].filter(n => !itSet.has(n)).sort();

console.log(`  ${c.yellow}Unmapped in bio.tools:${c.reset} ${missingBt.length} components`);
if (missingBt.length <= 20) {
  console.log(`    ${c.dim}${missingBt.join(', ')}${c.reset}`);
} else {
  console.log(`    ${c.dim}${missingBt.slice(0, 15).join(', ')}, +${missingBt.length - 15} more${c.reset}`);
}

console.log(`  ${c.yellow}Unmapped in EDAM:${c.reset} ${missingEdam.length} components`);
console.log(`  ${c.yellow}No iterator:${c.reset} ${missingIter.length} components ${c.dim}(expected for db ops, aggregation, etc.)${c.reset}`);

// Cross-coverage matrix
console.log(`\n${c.bold}${c.cyan}  Cross-Coverage: bio.tools ∩ EDAM${c.reset}\n`);
const both = [...compNames].filter(n => btSet.has(n) && edSet.has(n)).length;
const btOnly = [...compNames].filter(n => btSet.has(n) && !edSet.has(n)).length;
const edOnly = [...compNames].filter(n => !btSet.has(n) && edSet.has(n)).length;
const neither = [...compNames].filter(n => !btSet.has(n) && !edSet.has(n)).length;
console.log(`  Both:        ${c.green}${both}${c.reset}`);
console.log(`  bio.tools only: ${c.yellow}${btOnly}${c.reset}`);
console.log(`  EDAM only:      ${c.blue}${edOnly}${c.reset}`);
console.log(`  Neither:        ${c.dim}${neither}${c.reset}`);
console.log();
