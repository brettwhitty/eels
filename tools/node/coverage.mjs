#!/usr/bin/env node
// coverage.mjs — Coverage/mapping report across all registry and documentation sources
import { barLine, chalk } from './lib/display.mjs';
import { getCoverage, getBiotools, getEdam, getComponentNames } from './lib/data.mjs';

const coverage = getCoverage();
const compNames = new Set(getComponentNames());
const total = compNames.size;

const labels = {
  steps: 'Categorized Steps', docs: 'Documentation YAML', cwl: 'CWL Definitions',
  nextflow: 'Nextflow Processes', lite: 'Ergatis Lite', bco: 'BioCompute Objects',
  biotools: 'bio.tools Mapping', edam: 'EDAM Mapping', iterators: 'Iterator Defined',
};

console.log(`\n${chalk.bold.cyan('  EELS Coverage Report')}`);
console.log(chalk.dim(`  Coverage of ${total} extracted components across all artifact types\n`));

for (const [key, label] of Object.entries(labels)) {
  console.log(barLine(label, coverage[key].count, total, { barWidth: 40 }));
}

console.log(`\n${chalk.bold.cyan('  Gap Analysis')}\n`);
const btSet = new Set(coverage.biotools.names);
const edSet = new Set(coverage.edam.names);
const itSet = new Set(coverage.iterators.names);

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
