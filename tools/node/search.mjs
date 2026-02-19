#!/usr/bin/env node
// search.mjs — Rich component search with formatted output
// Usage: node search.mjs <query> [--category CAT] [--biotools] [--verbose]
import { componentHeader, chalk } from './lib/display.mjs';
import { searchComponents } from './lib/data.mjs';

const args = process.argv.slice(2);
const verbose = args.includes('--verbose') || args.includes('-v');
const biotoolsOnly = args.includes('--biotools');
let category = null;
const catIdx = args.indexOf('--category');
if (catIdx >= 0) { category = args[catIdx + 1]?.toLowerCase(); args.splice(catIdx, 2); }
const query = args.filter(a => !a.startsWith('-'))[0]?.toLowerCase();

if (!query && !category && !biotoolsOnly) {
  console.log(`\n  Usage: node search.mjs <query> [--category CAT] [--biotools] [--verbose]\n`);
  console.log(`  Examples:`);
  console.log(`    node search.mjs blast`);
  console.log(`    node search.mjs --category "RNA-Seq" --verbose`);
  console.log(`    node search.mjs hmm --biotools\n`);
  process.exit(0);
}

const results = searchComponents({ query, category, biotoolsOnly });

console.log(`\n${chalk.bold.cyan(`  Search Results: ${results.length} components`)}\n`);

for (const r of results) {
  console.log(componentHeader(r.name, r.comp.classification, r.biotools, r.edam));

  if (r.iterator) {
    console.log(`    ${chalk.yellow('Iterator:')} ${r.iterator.iterator_template || 'none'}`);
  }

  if (verbose) {
    const params = (r.comp.parameters || [])
      .filter(p => !(p.name || p.key || '').match(/^(PIPELINEID|OUTPUT_TOKEN|COMPONENT_NAME|WORKFLOW_REPOSITORY|OUTPUT_DIRECTORY|TMP_DIR|ITERATOR|GROUP_COUNT|NODISTRIB|DOCS_DIR|BIN_DIR|COMPONENT_CONFIG)/))
      .slice(0, 8);
    if (params.length) {
      console.log(`    ${chalk.dim('Parameters:')}`);
      for (const p of params) {
        const name = p.name || p.key || '?';
        const val = p.default || p.value || '';
        console.log(`      ${chalk.dim(name)} = ${chalk.yellow(val || '(empty)')}`);
      }
    }
    if (r.hasDoc) console.log(`    ${chalk.dim(`Docs: generated/docs/component_docs/${r.name}.doc.yaml`)}`);
  }
  console.log();
}
