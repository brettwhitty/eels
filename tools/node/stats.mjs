#!/usr/bin/env node
// stats.mjs — Terminal dashboard summarizing the EELS repository artifacts
import { box, header, barLine, stat, divider, chalk } from './lib/display.mjs';
import { getSummary, getTools, getBiotools, getEdam, getPipelines, getDatabases,
         getIterators, getConverters, getArtifactCounts, getToolCategories } from './lib/data.mjs';

const a = getArtifactCounts();
const tools = getTools();
const { raw: biotools } = getBiotools();
const { raw: edam } = getEdam();
const pipelines = getPipelines();
const databases = getDatabases();
const converters = getConverters();
const iterators = getIterators();
const summary = getSummary();

const biotoolsMapped = biotools.mapping.filter(m => m.matched).length;
const edamMapped = edam.mapping.length;
const iterComps = Object.keys(iterators).length;

console.log('\n' + box(
  'EELS — Ergatis Extended Lifetime Support',
  'Preserving the Golden Age of Open Source Bioinformatics Engineering'
));

console.log(header('SOURCE DATA'));
console.log(stat(a.components, 'component configurations'));
console.log(stat(a.stepFiles, 'categorized workflow step files'));
console.log(stat(tools.length, 'tool executables cataloged'));
console.log(stat(pipelines.length, 'production pipeline templates'));
console.log(stat(databases.length, 'reference databases'));
console.log(stat(Object.keys(converters).length, 'converter mappings'));

console.log(header('GENERATED ARTIFACTS'));
console.log(`  ${chalk.dim('Documentation:')}`);
console.log(stat(a.docYamls, 'component doc YAML files', 'yellow'));
console.log(`  ${chalk.yellow(String(a.bcoComponents).padStart(5))} component BCOs              ${chalk.yellow(String(a.bcoPipelines).padStart(5))} pipeline BCOs`);
console.log(`  ${chalk.dim('Workflow Languages:')}`);
console.log(stat(a.cwl, 'CWL tool definitions', 'cyan'));
console.log(`  ${chalk.cyan(String(a.nfComponents).padStart(5))} Nextflow component processes ${chalk.cyan(String(a.nfPipelines).padStart(5))} pipeline workflows`);
console.log(`  ${chalk.cyan(String(a.liteComponents).padStart(5))} Ergatis Lite components      ${chalk.cyan(String(a.litePipelines).padStart(5))} pipeline templates`);

console.log(header('REGISTRY MAPPINGS'));
console.log(barLine('bio.tools', biotoolsMapped, a.components, { color: 'green' }));
console.log(barLine('EDAM', edamMapped, a.components, { color: 'blue' }));
console.log(barLine('Iterators', iterComps, a.components, { color: 'magenta' }));

console.log(header('TOOL EXECUTABLES BY CATEGORY'));
const toolCats = getToolCategories();
const catLabels = { custom_perl: 'Custom Perl', open_source: 'Open Source', custom_binary: 'Custom Binary', os_system: 'OS/System', closed_source: 'Closed Source' };
const maxTool = Math.max(...Object.values(toolCats).map(c => c.count));
for (const [id, cat] of Object.entries(toolCats).sort((a, b) => b[1].count - a[1].count)) {
  console.log(barLine(catLabels[id] || id, cat.count, maxTool, { barWidth: 25, color: 'yellow', showTotal: false }));
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

const totalArtifacts = a.docYamls + a.bcoComponents + a.bcoPipelines + a.cwl + a.nfComponents + a.nfPipelines + a.liteComponents + a.litePipelines;
console.log('\n' + divider());
console.log(`  ${chalk.bold(`Total: ${chalk.cyan(a.components)} components → ${chalk.yellow(totalArtifacts)} generated artifacts`)}`);
console.log(divider() + '\n');
