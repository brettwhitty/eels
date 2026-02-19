#!/usr/bin/env node
// tree.mjs — Visual component category tree with counts and sample components
import { readFileSync } from 'fs';
import { join, resolve } from 'path';

const root = resolve(import.meta.dirname, '../..');
const load = f => JSON.parse(readFileSync(join(root, f), 'utf8'));

const c = {
  reset: '\x1b[0m', bold: '\x1b[1m', dim: '\x1b[2m',
  green: '\x1b[32m', yellow: '\x1b[33m', blue: '\x1b[34m',
  magenta: '\x1b[35m', cyan: '\x1b[36m',
};

const compDir = join(root, 'data', 'components');
const { readdirSync } = await import('fs');
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

// Sort by total count
const topEntries = Object.entries(tree).map(([top, subs]) => {
  const total = Object.values(subs).reduce((s, a) => s + a.length, 0);
  return [top, subs, total];
}).sort((a, b) => b[2] - a[2]);

console.log(`\n${c.bold}${c.cyan}  Ergatis Component Classification Tree${c.reset}`);
console.log(`${c.dim}  ${compFiles.length} components across ${topEntries.length} top-level categories${c.reset}\n`);

for (let i = 0; i < topEntries.length; i++) {
  const [top, subs, total] = topEntries[i];
  const isLast = i === topEntries.length - 1;
  const prefix = isLast ? '└' : '├';
  const childPrefix = isLast ? ' ' : '│';

  console.log(`  ${c.dim}${prefix}──${c.reset} ${c.bold}${c.green}${top}${c.reset} ${c.dim}(${total})${c.reset}`);

  const subEntries = Object.entries(subs).sort((a, b) => b[1].length - a[1].length);
  for (let j = 0; j < subEntries.length; j++) {
    const [sub, comps] = subEntries[j];
    const subLast = j === subEntries.length - 1;
    const sp = subLast ? '└' : '├';

    if (sub === '_root' && subEntries.length === 1) {
      // No subcategories, show components directly
      const sample = comps.slice(0, 5).join(', ');
      const more = comps.length > 5 ? `, ${c.dim}+${comps.length - 5} more${c.reset}` : '';
      console.log(`  ${c.dim}${childPrefix}   ${c.reset}${c.yellow}${sample}${c.reset}${more}`);
    } else if (sub === '_root') {
      const sample = comps.slice(0, 3).join(', ');
      const more = comps.length > 3 ? ` +${comps.length - 3}` : '';
      console.log(`  ${c.dim}${childPrefix}  ${sp}──${c.reset} ${c.dim}(uncategorized ${comps.length})${c.reset} ${c.yellow}${sample}${c.dim}${more}${c.reset}`);
    } else {
      const sample = comps.slice(0, 3).join(', ');
      const more = comps.length > 3 ? ` +${comps.length - 3}` : '';
      console.log(`  ${c.dim}${childPrefix}  ${sp}──${c.reset} ${c.blue}${sub}${c.reset} ${c.dim}(${comps.length})${c.reset} ${c.yellow}${sample}${c.dim}${more}${c.reset}`);
    }
  }
}
console.log();
