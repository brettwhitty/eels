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
const listTypes = args.includes('--types');

console.log('\n' + box(
  'Runtime Resource Dependencies',
  'Hardcoded paths, external tools, databases, and libraries required by Ergatis components'
));

if (listTypes) {
  console.log(header('RESOURCE TYPES'));
  const types = Object.entries(data.summary.by_type).sort((a, b) => b[1] - a[1]);
  for (const [type, count] of types) {
    const desc = data.summary.runtime_categories[type] || '';
    console.log(`  ${chalk.bold(String(count).padStart(4))}  ${chalk.green(type)}`);
    if (desc) console.log(`        ${chalk.dim(desc)}`);
  }
  console.log();
} else if (!typeFilter) {
  // Overview
  console.log(header('RESOURCE TYPES'));
  const types = Object.entries(data.summary.by_type).sort((a, b) => b[1] - a[1]);
  for (const [type, count] of types) {
    const desc = data.summary.runtime_categories[type] || '';
    console.log(`  ${chalk.bold(String(count).padStart(4))}  ${chalk.green(type)}`);
    if (desc) console.log(`        ${chalk.dim(desc)}`);
  }

  // Template var subtypes
  const tvars = data.resources.filter(r => r.type === 'template_var');
  const subs = {};
  for (const r of tvars) (subs[r.subtype] ??= []).push(r);
  console.log(header('TEMPLATE VARIABLES BY SUBTYPE'));
  for (const [sub, entries] of Object.entries(subs).sort((a, b) => b[1].length - a[1].length)) {
    console.log(`  ${chalk.bold(String(entries.length).padStart(4))}  ${chalk.yellow(sub)}`);
  }

  // Hardcoded literal paths that need attention
  console.log(header('HARDCODED DATABASE PATHS'));
  for (const r of data.resources.filter(r => r.type === 'database')) {
    console.log(`  ${chalk.cyan(r.resource)}`);
    console.log(`    ${chalk.dim(r.original_paths[0])} ${chalk.dim(`(${r.components.join(', ')})`)}`);
  }

  console.log(header('HARDCODED PACKAGE INSTALLS (need remapping)'));
  for (const r of data.resources.filter(r => r.type === 'package_install')) {
    console.log(`  ${chalk.magenta(r.resource)}`);
    console.log(`    ${chalk.dim(r.original_paths[0])} → ${chalk.dim(r.note)}`);
  }

  console.log(`\n${chalk.dim('  --types          list types only')}`);
  console.log(`${chalk.dim('  --type TYPE      filter (e.g. --type database, --type template_var, --type executable)')}\n`);
} else {
  // Filtered view
  const subtypes = ['executable','bin_dir','path','directory','library','install','other'];
  let items;
  // Check top-level type first, then subtype
  const byType = data.resources.filter(r => r.type === typeFilter);
  if (byType.length > 0) {
    items = byType;
  } else if (subtypes.includes(typeFilter)) {
    items = data.resources.filter(r => r.subtype === typeFilter);
  } else {
    items = [];
  }

  if (items.length === 0) {
    console.log(`\n  No resources matching "${typeFilter}"\n`);
  } else if (items[0].subtype) {
    // Template vars grouped by subtype
    const groups = {};
    for (const r of items) (groups[r.subtype || 'other'] ??= []).push(r);
    for (const [sub, entries] of Object.entries(groups).sort((a, b) => b[1].length - a[1].length)) {
      console.log(header(`${sub.toUpperCase()} (${entries.length})`));
      for (const r of entries) {
        console.log(`  ${chalk.yellow(r.resource.padEnd(35))} ${chalk.dim(r.components.join(', '))}`);
      }
    }
  } else {
    console.log(header(`${typeFilter.toUpperCase()} (${items.length} resources)`));
    for (const r of items) {
      console.log(`\n  ${chalk.bold.green(r.resource)}`);
      console.log(`    ${chalk.dim('Note:')} ${r.note}`);
      if (r.original_paths.length) console.log(`    ${chalk.dim('Paths:')} ${r.original_paths.join(', ')}`);
      console.log(`    ${chalk.dim('Components:')} ${r.components.join(', ')}`);
    }
  }
  console.log();
}
