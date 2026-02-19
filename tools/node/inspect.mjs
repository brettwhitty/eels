#!/usr/bin/env node
// inspect.mjs — Deep component inspector
// Usage: node inspect.mjs <component_name>
//        node inspect.mjs --runnable          (show runnability summary for all components)
import { readFileSync, readdirSync, existsSync } from 'fs';
import { join, resolve } from 'path';
import { box, header, barLine, divider, chalk } from './lib/display.mjs';
import { getComponents, getTools, getBiotools, getEdam, getIterators,
         getConverters, getPipelines } from './lib/data.mjs';

const root = resolve(import.meta.dirname, '../..');
const args = process.argv.slice(2);
const showRunnable = args.includes('--runnable');
const query = args.filter(a => !a.startsWith('-'))[0]?.toLowerCase();

// Build executable → tool mapping
const toolCatalog = getTools();
const exeMap = {};
for (const t of toolCatalog) {
  const basename = t.name;
  exeMap[basename] = t;
  // Also map by full path basename
  const pathBase = t.path?.split('/').pop();
  if (pathBase) exeMap[pathBase] = t;
}

function resolveExe(exe) {
  // Strip template vars: {{BIN_DIR}}/foo → foo
  const clean = exe.replace(/\{\{[^}]+\}\}\//g, '');
  const basename = clean.split('/').pop();
  return exeMap[basename] || null;
}

function loadSteps(name) {
  const f = join(root, 'data', 'categorized_steps', `${name}.json`);
  if (!existsSync(f)) return null;
  return JSON.parse(readFileSync(f, 'utf8'));
}

function loadDoc(name) {
  const f = join(root, 'generated', 'docs', 'component_docs', `${name}.doc.yaml`);
  if (!existsSync(f)) return null;
  return readFileSync(f, 'utf8');
}

// ── Runnability summary ──────────────────────────────────────────────
if (showRunnable) {
  const stepDir = join(root, 'data', 'categorized_steps');
  const files = readdirSync(stepDir).filter(f => f.endsWith('.json'));

  let totalComps = 0, fullyMapped = 0, partiallyMapped = 0, unmapped = 0;
  const issues = [];

  for (const f of files) {
    const data = JSON.parse(readFileSync(join(stepDir, f), 'utf8'));
    const name = data.component;
    const toolSteps = (data.steps || []).filter(s => s.category === 'tool_execution');
    if (toolSteps.length === 0) continue;
    totalComps++;

    let mapped = 0, missing = [];
    for (const step of toolSteps) {
      const tool = resolveExe(step.executable);
      if (tool) mapped++;
      else missing.push(step.executable.replace(/\{\{[^}]+\}\}\//g, ''));
    }

    if (mapped === toolSteps.length) fullyMapped++;
    else if (mapped > 0) { partiallyMapped++; issues.push({ name, missing, total: toolSteps.length, mapped }); }
    else { unmapped++; issues.push({ name, missing, total: toolSteps.length, mapped: 0 }); }
  }

  console.log('\n' + box('Component Runnability Analysis', 'Are all tool execution steps mapped to known executables?'));
  console.log();
  console.log(`  ${chalk.green('■')} Fully mapped:    ${chalk.bold.green(fullyMapped)} components — all tool steps have known executables`);
  console.log(`  ${chalk.yellow('■')} Partially mapped: ${chalk.bold.yellow(partiallyMapped)} components — some steps unresolved`);
  console.log(`  ${chalk.red('■')} Unmapped:         ${chalk.bold.red(unmapped)} components — no tool steps resolved`);
  console.log(`  ${chalk.dim('  Total with tool steps: ' + totalComps)}`);
  console.log();

  if (issues.length) {
    console.log(header('COMPONENTS WITH UNRESOLVED EXECUTABLES'));
    for (const { name, missing, total, mapped } of issues.sort((a, b) => a.mapped - b.mapped)) {
      const status = mapped === 0 ? chalk.red('✗') : chalk.yellow('◐');
      console.log(`  ${status} ${chalk.bold(name)} ${chalk.dim(`(${mapped}/${total} steps mapped)`)}`);
      for (const m of missing) {
        console.log(`      ${chalk.red('?')} ${chalk.dim(m)}`);
      }
    }
  }
  console.log();
  process.exit(0);
}

// ── Single component inspection ──────────────────────────────────────
if (!query) {
  console.log(`\n  Usage:`);
  console.log(`    node inspect.mjs <component>     Inspect a single component`);
  console.log(`    node inspect.mjs --runnable       Runnability summary for all components\n`);
  process.exit(0);
}

const components = getComponents();
const match = Object.keys(components).find(n => n.toLowerCase() === query)
  || Object.keys(components).find(n => n.toLowerCase().includes(query));

if (!match) { console.error(`No component matching "${query}"`); process.exit(1); }

const comp = components[match];
const { map: btMap } = getBiotools();
const { map: edMap } = getEdam();
const iterators = getIterators();
const converters = getConverters();
const pipelines = getPipelines();
const steps = loadSteps(match);

console.log('\n' + box(match, comp.classification || 'unclassified'));

// Bio.tools / EDAM
const bt = btMap[match];
const ed = edMap[match];
if (bt) console.log(`\n  ${chalk.blue('bio.tools:')} ${bt.name}  ${chalk.dim(bt.url)}`);
if (ed) {
  if (ed.operations?.length) console.log(`  ${chalk.magenta('EDAM operations:')} ${ed.operations.join(', ')}`);
  if (ed.topics?.length) console.log(`  ${chalk.magenta('EDAM topics:')} ${ed.topics.join(', ')}`);
}

// Iterator
const iter = iterators[match];
if (iter) {
  console.log(`\n  ${chalk.yellow('Iterator:')} ${iter.iterator_template || 'none'}`);
} else {
  console.log(`\n  ${chalk.dim('No iterator (non-parallelized component)')}`);
}

// Workflow steps with runnability
if (steps?.steps?.length) {
  console.log(header('WORKFLOW STEPS'));
  for (const step of steps.steps) {
    const tool = resolveExe(step.executable);
    // Normalize display but keep literal paths intact
    const exeDisplay = step.executable;
    const catColor = { tool_execution: 'green', converter: 'blue', provenance: 'magenta',
                       compression: 'dim', validation: 'yellow', infrastructure: 'cyan' }[step.category] || 'white';
    const catBadge = chalk[catColor](`[${step.category}]`);

    // Color the executable path by what it is
    let exeStyled;
    if (exeDisplay.match(/^\{\{[^}]+\}\}$/)) {
      // Pure template var (e.g. {{BLASTALL_EXEC}}) — unresolved external tool
      exeStyled = chalk.red(exeDisplay);
    } else if (exeDisplay.match(/^\//)) {
      // Literal absolute path — show exact path, color by location
      if (exeDisplay.match(/^\/bin\/|^\/usr\/bin\//)) exeStyled = chalk.dim(exeDisplay);
      else if (exeDisplay.match(/^\/usr\/local\/bin\//)) exeStyled = chalk.yellow(exeDisplay);
      else if (exeDisplay.match(/^\/usr\/local\/(packages|common|devel)\//)) exeStyled = chalk.magenta(exeDisplay);
      else if (exeDisplay.match(/^\/opt\//)) exeStyled = chalk.magenta(exeDisplay);
      else exeStyled = chalk.yellow(exeDisplay);
    } else if (exeDisplay.match(/^\{\{BIN_DIR\}\}\//)) {
      // Ergatis script
      exeStyled = chalk.cyan(exeDisplay);
    } else if (exeDisplay.match(/^\{\{/)) {
      // Template var prefix + path
      exeStyled = chalk.yellow(exeDisplay);
    } else {
      exeStyled = chalk.white(exeDisplay);
    }

    let status = '';
    if (step.category === 'tool_execution') {
      if (tool) {
        const catLabel = { open_source: chalk.green('open source'), custom_perl: chalk.cyan('custom Perl'),
                           custom_binary: chalk.yellow('custom binary'), os_system: chalk.dim('OS/system'),
                           closed_source: chalk.red('closed source') }[tool.category_id] || tool.category_id;
        status = `\n      ${chalk.green('✓')} ${catLabel}`;
      } else {
        status = `\n      ${chalk.red('? unresolved')}`;
      }
    }

    console.log(`  ${chalk.dim(String(step.idx).padStart(2) + '.')} ${step.name || '(unnamed)'}`);
    console.log(`      ${catBadge}  ${exeStyled}${status}`);
  }
}

// Parameters (all of them, not truncated)
const params = (comp.parameters || [])
  .filter(p => !(p.name || p.key || '').match(/^(PIPELINEID|OUTPUT_TOKEN|COMPONENT_NAME|WORKFLOW_REPOSITORY|OUTPUT_DIRECTORY|TMP_DIR|ITERATOR1?|GROUP_COUNT|NODISTRIB|DOCS_DIR|BIN_DIR|COMPONENT_CONFIG)/));
if (params.length) {
  console.log(header('PARAMETERS'));
  for (const p of params) {
    const name = p.name || p.key || '?';
    const val = p.default || p.value || '';
    console.log(`  ${chalk.bold(name)}`);
    if (val) console.log(`    ${chalk.yellow(val)}`);
  }
}

// Which pipelines use this component
const usedIn = pipelines.filter(p => p.components.some(c => c.split('.')[0] === match));
if (usedIn.length) {
  console.log(header('USED IN PIPELINES'));
  for (const p of usedIn) {
    const instances = p.components.filter(c => c.split('.')[0] === match);
    console.log(`  ${chalk.green(p.name)} ${chalk.dim(`(${instances.length}x: ${instances.join(', ')})`)} `);
  }
}

// Doc file pointer
const docFile = `generated/docs/component_docs/${match}.doc.yaml`;
if (existsSync(join(root, docFile))) {
  console.log(`\n  ${chalk.dim(`Full docs: ${docFile}`)}`);
}

console.log();
