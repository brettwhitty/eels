#!/usr/bin/env node
// resources.mjs — Display runtime resource dependencies
// Usage: node resources.mjs                    Overview
//        node resources.mjs --type TYPE        Filter by type
//        node resources.mjs --rebuild          Regenerate resource_map.json first
import { readFileSync, existsSync } from 'fs';
import { join, resolve } from 'path';
import { execSync } from 'child_process';
import { box, header, chalk } from './lib/display.mjs';

const root = resolve(import.meta.dirname, '../..');
const mapFile = join(root, 'data', 'resource_map.json');

const args = process.argv.slice(2);
if (args.includes('--rebuild') || !existsSync(mapFile)) {
  console.log(chalk.dim('  Rebuilding resource map...'));
  execSync('node tools/node/resource_map.mjs', { cwd: root, stdio: 'inherit' });
}

const data = JSON.parse(readFileSync(mapFile, 'utf8'));
const typeFilter = args.find((a, i) => args[i - 1] === '--type')?.toLowerCase();

console.log('\n' + box(
  'Runtime Resource Dependencies',
  'Hardcoded paths, external tools, databases, and libraries required by Ergatis components'
));

if (!typeFilter) {
  // Overview
  console.log(header('RESOURCE TYPES'));
  const types = Object.entries(data.summary.by_type).sort((a, b) => b[1] - a[1]);
  for (const [type, count] of types) {
    const desc = data.summary.runtime_categories[type] || '';
    console.log(`  ${chalk.bold(String(count).padStart(4))}  ${chalk.green(type)}`);
    if (desc) console.log(`        ${chalk.dim(desc)}`);
  }

  // Show the critical ones: external tools that must be installed
  console.log(header('EXTERNAL TOOL EXECUTABLES (must be installed)'));
  const execs = data.resources.filter(r => r.type === 'tool_executable').sort((a, b) => b.num_components - a.num_components);
  for (const r of execs) {
    console.log(`  ${chalk.yellow(r.resource.padEnd(30))} ${chalk.dim(`${r.num_components} component${r.num_components > 1 ? 's' : ''}: ${r.components.slice(0, 5).join(', ')}${r.components.length > 5 ? ' ...' : ''}`)}`);
  }

  console.log(header('REFERENCE DATABASES'));
  const dbs = data.resources.filter(r => r.type === 'database');
  for (const r of dbs) {
    const origPath = r.original_paths[0] || '';
    console.log(`  ${chalk.cyan(r.resource)}`);
    console.log(`    ${chalk.dim(origPath)} ${chalk.dim(`(${r.components.join(', ')})`)}`);
  }

  console.log(header('INSTITUTIONAL PACKAGE INSTALLS (need remapping)'));
  const pkgs = data.resources.filter(r => r.type === 'package_install');
  for (const r of pkgs) {
    console.log(`  ${chalk.magenta(r.resource)}`);
    console.log(`    ${chalk.dim(r.original_paths[0])} → ${chalk.dim(r.note)}`);
  }

  console.log(`\n${chalk.dim('  Use --type <type> to filter, e.g.: node resources.mjs --type tool_executable')}\n`);
} else {
  // Filtered view
  const items = data.resources.filter(r => r.type.toLowerCase().includes(typeFilter));
  console.log(header(`${typeFilter.toUpperCase()} (${items.length} resources)`));
  for (const r of items) {
    console.log(`\n  ${chalk.bold.green(r.resource)}`);
    console.log(`    ${chalk.dim('Type:')} ${r.type}`);
    console.log(`    ${chalk.dim('Note:')} ${r.note}`);
    if (r.original_paths.length) console.log(`    ${chalk.dim('Paths:')} ${r.original_paths.join(', ')}`);
    console.log(`    ${chalk.dim('Components:')} ${r.components.join(', ')}`);
  }
  console.log();
}
