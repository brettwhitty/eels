#!/usr/bin/env node
// stats.mjs — Terminal dashboard summarizing the EELS repository artifacts
import { readFileSync, readdirSync, statSync } from 'fs';
import { join, resolve } from 'path';

const root = resolve(import.meta.dirname, '../..');
const load = f => JSON.parse(readFileSync(join(root, f), 'utf8'));
const count = (dir, ext) => {
  try { return readdirSync(join(root, dir)).filter(f => f.endsWith(ext)).length; }
  catch { return 0; }
};
const fsize = f => {
  try { return statSync(join(root, f)).size; }
  catch { return 0; }
};
const fmt = n => String(n).padStart(5);
const bar = (n, max, w = 30) => {
  const filled = Math.round((n / max) * w);
  return '█'.repeat(filled) + '░'.repeat(w - filled);
};

// ANSI colors
const c = {
  reset: '\x1b[0m', bold: '\x1b[1m', dim: '\x1b[2m',
  red: '\x1b[31m', green: '\x1b[32m', yellow: '\x1b[33m',
  blue: '\x1b[34m', magenta: '\x1b[35m', cyan: '\x1b[36m', white: '\x1b[37m',
  bgBlue: '\x1b[44m', bgMagenta: '\x1b[45m',
};

const line = (ch = '─', w = 72) => c.dim + ch.repeat(w) + c.reset;
const header = text => `\n${c.bold}${c.bgBlue}${c.white} ${text.padEnd(70)} ${c.reset}`;

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

// Tool categories
const toolCats = {};
for (const t of tools) {
  toolCats[t.category_id] = (toolCats[t.category_id] || 0) + 1;
}

// Component classifications
const classes = summary.components_by_classification;
const classEntries = Object.entries(classes).sort((a, b) => b[1] - a[1]);
const maxClass = classEntries[0]?.[1] || 1;

// --- Output ---
const boxW = 70;
const l1 = '   EELS \u2014 Ergatis Extended Lifetime Support'.padEnd(boxW);
const l2 = '   Preserving the Golden Age of bioinformatics workflow engineering'.padEnd(boxW);
console.log(`\n${c.bold}${c.cyan}  \u2554${'═'.repeat(boxW)}\u2557${c.reset}`);
console.log(`${c.bold}${c.cyan}  \u2551${c.reset}${c.bold}${l1}${c.bold}${c.cyan}\u2551${c.reset}`);
console.log(`${c.bold}${c.cyan}  \u2551${c.reset}${c.dim}${l2}${c.bold}${c.cyan}\u2551${c.reset}`);
console.log(`${c.bold}${c.cyan}  \u255a${'═'.repeat(boxW)}\u255d${c.reset}`);

console.log(header('SOURCE DATA'));
console.log(`  ${c.bold}${c.green}${fmt(components)}${c.reset} component configurations`);
console.log(`  ${c.bold}${c.green}${fmt(stepFiles)}${c.reset} categorized workflow step files`);
console.log(`  ${c.bold}${c.green}${fmt(tools.length)}${c.reset} tool executables cataloged`);
console.log(`  ${c.bold}${c.green}${fmt(pipelines.length)}${c.reset} production pipeline templates`);
console.log(`  ${c.bold}${c.green}${fmt(databases.length)}${c.reset} reference databases`);
console.log(`  ${c.bold}${c.green}${fmt(Object.keys(converters).length)}${c.reset} converter mappings`);

console.log(header('GENERATED ARTIFACTS'));
console.log(`  ${c.dim}Documentation:${c.reset}`);
console.log(`    ${c.yellow}${fmt(docYamls)}${c.reset} component doc YAML files`);
console.log(`    ${c.yellow}${fmt(bcoComps)}${c.reset} component BioCompute Objects    ${c.yellow}${fmt(bcoPipes)}${c.reset} pipeline BCOs`);
console.log(`  ${c.dim}Workflow Languages:${c.reset}`);
console.log(`    ${c.cyan}${fmt(cwlFiles)}${c.reset} CWL tool definitions`);
console.log(`    ${c.cyan}${fmt(nfComps)}${c.reset} Nextflow component processes    ${c.cyan}${fmt(nfPipes)}${c.reset} pipeline workflows`);
console.log(`    ${c.cyan}${fmt(liteComps)}${c.reset} Ergatis Lite components         ${c.cyan}${fmt(litePipes)}${c.reset} pipeline templates`);

console.log(header('REGISTRY MAPPINGS'));
const btPct = Math.round(biotoolsMapped / components * 100);
const edPct = Math.round(edamMapped / components * 100);
const itPct = Math.round(iterComps / components * 100);
console.log(`  bio.tools  ${c.green}${bar(biotoolsMapped, components)}${c.reset} ${fmt(biotoolsMapped)}/${components} (${btPct}%)`);
console.log(`  EDAM       ${c.blue}${bar(edamMapped, components)}${c.reset} ${fmt(edamMapped)}/${components} (${edPct}%)`);
console.log(`  Iterators  ${c.magenta}${bar(iterComps, components)}${c.reset} ${fmt(iterComps)}/${components} (${itPct}%)`);

console.log(header('TOOL EXECUTABLES BY CATEGORY'));
const catLabels = {
  custom_perl: 'Custom Perl',
  open_source: 'Open Source',
  custom_binary: 'Custom Binary',
  os_system: 'OS/System',
  closed_source: 'Closed Source',
};
const maxTool = Math.max(...Object.values(toolCats));
for (const [id, n] of Object.entries(toolCats).sort((a, b) => b[1] - a[1])) {
  const label = (catLabels[id] || id).padEnd(15);
  console.log(`  ${label} ${c.yellow}${bar(n, maxTool, 25)}${c.reset} ${fmt(n)}`);
}

console.log(header('COMPONENT CLASSIFICATIONS (top 15)'));
for (const [cls, n] of classEntries.slice(0, 15)) {
  const label = cls.padEnd(32);
  console.log(`  ${label} ${c.green}${bar(n, maxClass, 20)}${c.reset} ${fmt(n)}`);
}
if (classEntries.length > 15) {
  console.log(`  ${c.dim}  ... and ${classEntries.length - 15} more categories${c.reset}`);
}

console.log(header('PIPELINE TEMPLATES (by size)'));
const sortedPipes = [...pipelines].sort((a, b) => b.num_components - a.num_components);
const maxPipe = sortedPipes[0]?.num_components || 1;
for (const p of sortedPipes.slice(0, 10)) {
  const label = p.name.replace(/_/g, ' ').slice(0, 35).padEnd(36);
  console.log(`  ${label} ${c.magenta}${bar(p.num_components, maxPipe, 18)}${c.reset} ${fmt(p.num_components)} steps`);
}
if (sortedPipes.length > 10) {
  console.log(`  ${c.dim}  ... and ${sortedPipes.length - 10} more pipelines${c.reset}`);
}

console.log('\n' + line());
const totalArtifacts = docYamls + bcoComps + bcoPipes + cwlFiles + nfComps + nfPipes + liteComps + litePipes;
console.log(`  ${c.bold}Total: ${c.cyan}${components}${c.reset}${c.bold} components → ${c.yellow}${totalArtifacts}${c.reset}${c.bold} generated artifacts${c.reset}`);
console.log(line() + '\n');
