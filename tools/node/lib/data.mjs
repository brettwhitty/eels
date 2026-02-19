// tools/node/lib/data.mjs — Shared data loading layer for EELS tools
// Pure data, no display logic. Usable from terminal tools, web servers, or build scripts.
import { readFileSync, readdirSync, existsSync } from 'fs';
import { join, resolve } from 'path';

const root = resolve(import.meta.dirname, '../../..');

const load = f => JSON.parse(readFileSync(join(root, f), 'utf8'));
const dirNames = (dir, ext) => {
  try { return readdirSync(join(root, dir)).filter(f => f.endsWith(ext)).map(f => f.replace(ext, '')); }
  catch { return []; }
};

// ── Component data ───────────────────────────────────────────────────

export function getComponents() {
  const dir = join(root, 'data', 'components');
  const files = readdirSync(dir).filter(f => f.endsWith('.json'));
  const components = {};
  for (const f of files) {
    components[f.replace('.json', '')] = JSON.parse(readFileSync(join(dir, f), 'utf8'));
  }
  return components;
}

export function getComponentNames() {
  return dirNames('data/components', '.json');
}

// ── Catalogs ─────────────────────────────────────────────────────────

export function getSummary() { return load('data/component_summary.json'); }
export function getTools() { return load('data/tool_catalog_full.json'); }
export function getPipelines() { return load('data/pipeline_catalog.json'); }
export function getDatabases() { return load('data/database_catalog.json'); }
export function getIterators() { return load('data/iterator_catalog.json'); }
export function getConverters() { return load('data/converter_mapping.json'); }

// ── Registry mappings ────────────────────────────────────────────────

export function getBiotools() {
  const raw = load('data/biotools_mapping.json');
  const map = {};
  for (const m of raw.mapping) {
    if (m.matched) map[m.component] = { id: m.biotoolsID, name: m.tool_name, url: m.bio_tools_url };
  }
  return { raw, map };
}

export function getEdam() {
  const raw = load('data/edam_mapping.json');
  const map = {};
  for (const m of raw.mapping) {
    map[m.component] = { operations: m.edam_operations || [], topics: m.edam_topics || [] };
  }
  return { raw, map };
}

// ── Artifact counts ──────────────────────────────────────────────────

export function getArtifactCounts() {
  return {
    components: dirNames('data/components', '.json').length,
    stepFiles: dirNames('data/categorized_steps', '.json').length,
    docYamls: dirNames('generated/docs/component_docs', '.doc.yaml').length,
    cwl: dirNames('generated/wfl-lang/cwl/components', '.cwl').length,
    nfComponents: dirNames('generated/wfl-lang/nextflow/components', '.nf').length,
    nfPipelines: dirNames('generated/wfl-lang/nextflow/pipeline_templates', '.nf').length,
    liteComponents: dirNames('generated/wfl-lang/ergatis_lite/components', '.lite').length,
    litePipelines: dirNames('generated/wfl-lang/ergatis_lite/pipeline_templates', '.lite').length,
    bcoComponents: dirNames('generated/docs/bco/components', '.json').length,
    bcoPipelines: dirNames('generated/docs/bco/pipeline_templates', '.json').length,
  };
}

// ── Coverage sets ────────────────────────────────────────────────────

export function getCoverage() {
  const compNames = new Set(getComponentNames());
  const sets = {
    steps: new Set(dirNames('data/categorized_steps', '.json')),
    docs: new Set(dirNames('generated/docs/component_docs', '.doc.yaml')),
    cwl: new Set(dirNames('generated/wfl-lang/cwl/components', '.cwl')),
    nextflow: new Set(dirNames('generated/wfl-lang/nextflow/components', '.nf')),
    lite: new Set(dirNames('generated/wfl-lang/ergatis_lite/components', '.lite')),
    bco: new Set(dirNames('generated/docs/bco/components', '.json')),
    biotools: new Set(getBiotools().raw.mapping.filter(m => m.matched).map(m => m.component)),
    edam: new Set(getEdam().raw.mapping.map(m => m.component)),
    iterators: new Set(Object.keys(getIterators())),
  };
  // Compute counts intersected with known components
  const coverage = {};
  for (const [key, set] of Object.entries(sets)) {
    const matched = [...set].filter(s => compNames.has(s));
    coverage[key] = { count: matched.length, total: compNames.size, names: matched };
  }
  return coverage;
}

// ── Classifications tree ─────────────────────────────────────────────

export function getClassificationTree() {
  const components = getComponents();
  const tree = {};
  for (const [name, comp] of Object.entries(components)) {
    const cls = comp.classification || 'unclassified';
    const parts = cls.split(/\s*\/\s*/);
    const top = parts[0] || 'unclassified';
    const sub = parts.slice(1).join(' / ') || null;
    if (!tree[top]) tree[top] = {};
    const key = sub || '_root';
    if (!tree[top][key]) tree[top][key] = [];
    tree[top][key].push(name);
  }
  return tree;
}

// ── Tool categories ──────────────────────────────────────────────────

export function getToolCategories() {
  const tools = getTools();
  const cats = {};
  for (const t of tools) {
    if (!cats[t.category_id]) cats[t.category_id] = { label: t.category, count: 0, tools: [] };
    cats[t.category_id].count++;
    cats[t.category_id].tools.push(t.name);
  }
  return cats;
}

// ── Pipeline details ─────────────────────────────────────────────────

export function getPipelineDetail(name) {
  const pipelines = getPipelines();
  const pipeline = pipelines.find(p => p.name.toLowerCase().includes(name.toLowerCase()));
  if (!pipeline) return null;

  const instances = pipeline.components.map(c => {
    const parts = c.split('.');
    return { full: c, component: parts[0], group: parts.slice(1).join('.') || 'ungrouped' };
  });

  const groups = {};
  for (const inst of instances) {
    if (!groups[inst.group]) groups[inst.group] = [];
    groups[inst.group].push(inst);
  }

  return { pipeline, instances, groups };
}

// ── Search ───────────────────────────────────────────────────────────

export function searchComponents({ query, category, biotoolsOnly } = {}) {
  const components = getComponents();
  const { map: btMap } = getBiotools();
  const { map: edMap } = getEdam();
  const iterators = getIterators();

  const results = [];
  for (const [name, comp] of Object.entries(components)) {
    const cls = (comp.classification || '').toLowerCase();
    let match = true;
    if (query && !(name.toLowerCase().includes(query) || cls.includes(query))) match = false;
    if (category && !cls.includes(category)) match = false;
    if (biotoolsOnly && !btMap[name]) match = false;
    if (!query && !category && !biotoolsOnly) match = false;
    if (match) {
      results.push({
        name, comp,
        biotools: btMap[name] || null,
        edam: edMap[name] || null,
        iterator: iterators[name] || null,
        hasDoc: existsSync(join(root, 'generated/docs/component_docs', `${name}.doc.yaml`)),
      });
    }
  }
  return results.sort((a, b) => a.name.localeCompare(b.name));
}

export { root };
