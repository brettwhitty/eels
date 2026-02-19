#!/usr/bin/env node
// tree.mjs — Visual component category tree with counts and sample components
import { treeNode, treeChild, treeLeaf, chalk } from './lib/display.mjs';
import { getClassificationTree, getComponentNames } from './lib/data.mjs';

const tree = getClassificationTree();
const totalComps = getComponentNames().length;

const topEntries = Object.entries(tree).map(([top, subs]) => {
  const total = Object.values(subs).reduce((s, a) => s + a.length, 0);
  return [top, subs, total];
}).sort((a, b) => b[2] - a[2]);

console.log(`\n${chalk.bold.cyan('  Ergatis Component Classification Tree')}`);
console.log(chalk.dim(`  ${totalComps} components across ${topEntries.length} top-level categories\n`));

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
      console.log(treeChild('uncategorized', comps.length, comps, subLast, isLast));
    } else {
      console.log(treeChild(sub, comps.length, comps, subLast, isLast));
    }
  }
}
console.log();
