#!/usr/bin/env node
// coverage.mjs — Coverage/mapping report across all registry and documentation sources
import { readFileSync, readdirSync } from 'fs';
import { join, resolve } from 'path';
import { box, header, barLine, divider, chalk } from './lib/display.mjs';

const root = resolve(import.meta.dirname, '../..');
const load = f => JSON.parse(readFileSync(join(root, f), 'utf8'));
const nameSet = (dir, ext) => {
  try { return new Set(readdirSync(join(root, dir)).filter(f => f.endsWith(ext)).map(f => f.replace(ext, ''))); }
  catch { return new Set(); }
};

const compNames = nameSet('data/components', '.json');
const total = compNames.size;

const docSet = new Set(readdirSync(join(root, 'generated/docs/component_docs'))
  .filter(f => f.endsWith('.doc.yaml')).map(f => f.replace('.doc.yaml', '')));
const cwlSet = nameSet('generated/wfl-lang/cwl/components', '.cwl');
const nfSet = nameSet('generated/wfl-lang/nextflow/components', '.nf');
const liteSet = nameSet('generated/wfl-lang/ergatis_lite/components', '.lite');
const bcoSet = nameSet('generated/docs/bco/components', '.json');

const biotools = load('data/biotools_mapping.json');
const btSet = new Set(biotools.mapping.filter(m => m.matched).map(m => m.component));
const edam = load('data/edam_mapping.json');
const edSet = new Set(edam.mapping.map(m => m.component));
const iterators = load('data/iterator_catalog.json');
const itSet = new Set(Object.keys(iterators));
const stepSet = nameSet('data/categorized_steps', '.json');

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

console.log(`\n${chalk.bold.cyan('  EELS Coverage Report')}`);
console.log(chalk.dim(`  Coverage of ${total} extracted components across all artifact types\n`));

for (const [label, set] of sources) {
  const n = [...set].filter(s => compNames.has(s)).length;
  console.log(barLine(label, n, total, { barWidth: 40 }));
}

console.log(`\n${chalk.bold.cyan('  Gap Analysis')}\n`);
const missingBt = [...compNames].filter(n => !btSet.has(n)).sort();
const missingEdam = [...compNames].filter(n => !edSet.has(n)).sort();
const missingIter = [...compNames].filter(n => !itSet.has(n)).sort();

console.log(`  ${chalk.yellow('Unmapped in bio.tools:')} ${missingBt.length} components`);
if (missingBt.length <= 20) {
  console.log(`    ${chalk.dim(missingBt.join(', '))}`);
} else {
  console.log(`    ${chalk.dim(missingBt.slice(0, 15).join(', ') + `, +${missingBt.length - 15} more`)}`);
}
console.log(`  ${chalk.yellow('Unmapped in EDAM:')} ${missingEdam.length} components`);
console.log(`  ${chalk.yellow('No iterator:')} ${missingIter.length} components ${chalk.dim('(expected for db ops, aggregation, etc.)')}`);

console.log(`\n${chalk.bold.cyan('  Cross-Coverage: bio.tools ∩ EDAM')}\n`);
const both = [...compNames].filter(n => btSet.has(n) && edSet.has(n)).length;
const btOnly = [...compNames].filter(n => btSet.has(n) && !edSet.has(n)).length;
const edOnly = [...compNames].filter(n => !btSet.has(n) && edSet.has(n)).length;
const neither = [...compNames].filter(n => !btSet.has(n) && !edSet.has(n)).length;
console.log(`  Both:           ${chalk.green(both)}`);
console.log(`  bio.tools only: ${chalk.yellow(btOnly)}`);
console.log(`  EDAM only:      ${chalk.blue(edOnly)}`);
console.log(`  Neither:        ${chalk.dim(neither)}`);
console.log();
