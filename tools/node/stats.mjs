#!/usr/bin/env node
// stats.mjs — Terminal dashboard summarizing the EELS repository artifacts
import { readFileSync, readdirSync, statSync } from 'fs';
import { join, resolve } from 'path';
import { box, header, barLine, stat, divider, chalk } from './lib/display.mjs';

const root = resolve(import.meta.dirname, '../..');
const load = f => JSON.parse(readFileSync(join(root, f), 'utf8'));
const count = (dir, ext) => {
  try { return readdirSync(join(root, dir)).filter(f => f.endsWith(ext)).length; }
  catch { return 0; }
};

// --- Data ---
const components = count('data/components', '.json');
const stepFiles = count('data/categorized_steps', '.json');
const docYamls = count('generated/docs/component_docs', '.yaml');
const cwlFiles = count('generated/wfl-lang/cwl/components', '.cwl');
const nfComps = count('generated/wfl-lang/nextflow/components', '.nf');
const nfPipes = count('generated/wfl-lang/nextflow/pipeline_templates', '.nf');
const liteComps = count('generated/wfl-lang/ergatis_lite/components', '.lite');
const litePipes = count('generated/wfl-lang/ergatis_lite/pipeline_templates', '.lite');
const bcoComps = count('generated/docs/bco/components', '.json');
const bcoPipes = count('generated/docs/bco/pipeline_templates', '.json');

const summary = load('data/component_summary.json');
const tools = load('data/tool_catalog_full.json');
const biotools = load('data/biotools_mapping.json');
const edam = load('data/edam_mapping.json');
const pipelines = load('data/pipeline_catalog.json');
const databases = load('data/database_catalog.json');
const iterators = load('data/iterator_catalog.json');
const converters = load('data/converter_mapping.json');

const biotoolsMapped = biotools.mapping.filter(m => m.matched).length;
const edamMapped = edam.mapping.length;
const iterComps = Object.keys(iterators).length;

// --- Output ---
console.log('\n' + box(
  'EELS — Ergatis Extended Lifetime Support',
  'Preserving the Golden Age of Open Source Bioinformatics Engineering'
));

console.log(header('SOURCE DATA'));
console.log(stat(components, 'component configurations'));
console.log(stat(stepFiles, 'categorized workflow step files'));
console.log(stat(tools.length, 'tool executables cataloged'));
console.log(stat(pipelines.length, 'production pipeline templates'));
console.log(stat(databases.length, 'reference databases'));
console.log(stat(Object.keys(converters).length, 'converter mappings'));

console.log(header('GENERATED ARTIFACTS'));
console.log(`  ${chalk.dim('Documentation:')}`);
console.log(stat(docYamls, 'component doc YAML files', 'yellow'));
console.log(`  ${chalk.yellow(String(bcoComps).padStart(5))} component BCOs              ${chalk.yellow(String(bcoPipes).padStart(5))} pipeline BCOs`);
console.log(`  ${chalk.dim('Workflow Languages:')}`);
console.log(stat(cwlFiles, 'CWL tool definitions', 'cyan'));
console.log(`  ${chalk.cyan(String(nfComps).padStart(5))} Nextflow component processes ${chalk.cyan(String(nfPipes).padStart(5))} pipeline workflows`);
console.log(`  ${chalk.cyan(String(liteComps).padStart(5))} Ergatis Lite components      ${chalk.cyan(String(litePipes).padStart(5))} pipeline templates`);

console.log(header('REGISTRY MAPPINGS'));
console.log(barLine('bio.tools', biotoolsMapped, components, { color: 'green' }));
console.log(barLine('EDAM', edamMapped, components, { color: 'blue' }));
console.log(barLine('Iterators', iterComps, components, { color: 'magenta' }));

console.log(header('TOOL EXECUTABLES BY CATEGORY'));
const toolCats = {};
for (const t of tools) toolCats[t.category_id] = (toolCats[t.category_id] || 0) + 1;
const catLabels = { custom_perl: 'Custom Perl', open_source: 'Open Source', custom_binary: 'Custom Binary', os_system: 'OS/System', closed_source: 'Closed Source' };
const maxTool = Math.max(...Object.values(toolCats));
for (const [id, n] of Object.entries(toolCats).sort((a, b) => b[1] - a[1])) {
  console.log(barLine(catLabels[id] || id, n, maxTool, { barWidth: 25, color: 'yellow', showTotal: false }));
}

console.log(header('COMPONENT CLASSIFICATIONS (top 15)'));
const classEntries = Object.entries(summary.components_by_classification).sort((a, b) => b[1] - a[1]);
const maxClass = classEntries[0]?.[1] || 1;
for (const [cls, n] of classEntries.slice(0, 15)) {
  console.log(barLine(cls, n, maxClass, { labelWidth: 32, barWidth: 20, color: 'green', showTotal: false }));
}
if (classEntries.length > 15) console.log(chalk.dim(`    ... and ${classEntries.length - 15} more categories`));

console.log(header('PIPELINE TEMPLATES (by size)'));
const sortedPipes = [...pipelines].sort((a, b) => b.num_components - a.num_components);
const maxPipe = sortedPipes[0]?.num_components || 1;
for (const p of sortedPipes.slice(0, 10)) {
  const label = p.name.replace(/_/g, ' ').slice(0, 35);
  console.log(barLine(label, p.num_components, maxPipe, { labelWidth: 36, barWidth: 18, color: 'magenta', showTotal: false }) + ' steps');
}
if (sortedPipes.length > 10) console.log(chalk.dim(`    ... and ${sortedPipes.length - 10} more pipelines`));

const totalArtifacts = docYamls + bcoComps + bcoPipes + cwlFiles + nfComps + nfPipes + liteComps + litePipes;
console.log('\n' + divider());
console.log(`  ${chalk.bold(`Total: ${chalk.cyan(components)} components → ${chalk.yellow(totalArtifacts)} generated artifacts`)}`);
console.log(divider() + '\n');
