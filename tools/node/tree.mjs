#!/usr/bin/env node
// tree.mjs — Visual component category tree with counts and sample components
import { readFileSync, readdirSync } from 'fs';
import { join, resolve } from 'path';
import { treeNode, treeChild, treeLeaf, chalk } from './lib/display.mjs';

const root = resolve(import.meta.dirname, '../..');
const compDir = join(root, 'data', 'components');
const compFiles = readdirSync(compDir).filter(f => f.endsWith('.json'));

// Build classification tree: top/sub → [components]
const tree = {};
for (const f of compFiles) {
  const comp = JSON.parse(readFileSync(join(compDir, f), 'utf8'));
  const name = f.replace('.json', '');
  const cls = comp.classification || 'unclassified';
  const parts = cls.split(/\s*\/\s*/);
  const top = parts[0] || 'unclassified';
  const sub = parts.slice(1).join(' / ') || null;
  if (!tree[top]) tree[top] = {};
  const key = sub || '_root';
  if (!tree[top][key]) tree[top][key] = [];
  tree[top][key].push(name);
}

const topEntries = Object.entries(tree).map(([top, subs]) => {
  const total = Object.values(subs).reduce((s, a) => s + a.length, 0);
  return [top, subs, total];
}).sort((a, b) => b[2] - a[2]);

console.log(`\n${chalk.bold.cyan('  Ergatis Component Classification Tree')}`);
console.log(chalk.dim(`  ${compFiles.length} components across ${topEntries.length} top-level categories\n`));

for (let i = 0; i < topEntries.length; i++) {
  const [top, subs, total] = topEntries[i];
  const isLast = i === topEntries.length - 1;
  console.log(treeNode(top, total, isLast));

  const subEntries = Object.entries(subs).sort((a, b) => b[1].length - a[1].length);
  for (let j = 0; j < subEntries.length; j++) {
    const [sub, comps] = subEntries[j];
    const subLast = j === subEntries.length - 1;

    if (sub === '_root' && subEntries.length === 1) {
      console.log(treeLeaf(comps, isLast));
    } else if (sub === '_root') {
      console.log(treeChild(`uncategorized`, comps.length, comps, subLast, isLast));
    } else {
      console.log(treeChild(sub, comps.length, comps, subLast, isLast));
    }
  }
}
console.log();
