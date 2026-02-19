#!/usr/bin/env node
// resource_map.mjs — Extract and classify all runtime resource dependencies
// Generates data/resource_map.json with categorized paths, executables, and databases
import { readFileSync, writeFileSync, readdirSync } from 'fs';
import { join, resolve, basename } from 'path';

const root = resolve(import.meta.dirname, '../..');
const compDir = join(root, 'data', 'components');
const stepDir = join(root, 'data', 'categorized_steps');

// ── Collect all references ───────────────────────────────────────────

const refs = []; // {value, component, context, source}

// From config parameters
for (const f of readdirSync(compDir).filter(f => f.endsWith('.json'))) {
  const name = f.replace('.json', '');
  const comp = JSON.parse(readFileSync(join(compDir, f), 'utf8'));
  for (const p of (comp.parameters || [])) {
    const key = p.name || p.key || '';
    const val = p.default || p.value || '';
    if (!val) continue;

    // Absolute paths
    for (const m of (val.match(/\/[a-zA-Z][a-zA-Z0-9_\/.+-]+/g) || [])) {
      if (m.length >= 5) refs.push({ value: m, component: name, context: key, source: 'config_default' });
    }

    // Template variable references to paths/execs/dbs
    for (const m of (val.match(/\$;([A-Z_]+(?:PATH|DIR|EXEC|DB|LIB|BIN|INSTALL|HOME))\$;/g) || [])) {
      refs.push({ value: m, component: name, context: key, source: 'config_template_var' });
    }
  }
}

// From step executables
for (const f of readdirSync(stepDir).filter(f => f.endsWith('.json'))) {
  const data = JSON.parse(readFileSync(join(stepDir, f), 'utf8'));
  for (const step of (data.steps || [])) {
    const exe = step.executable || '';

    // Absolute paths in executables
    for (const m of (exe.match(/\/[a-zA-Z][a-zA-Z0-9_\/.+-]+/g) || [])) {
      if (m.length >= 5) refs.push({ value: m, component: data.component, context: `step:${step.name || step.idx}`, source: 'step_executable' });
    }

    // Template vars in executables
    for (const m of (exe.match(/\{\{([A-Z_]+)\}\}/g) || [])) {
      refs.push({ value: m, component: data.component, context: `step:${step.name || step.idx}`, source: 'step_template_var' });
    }
  }
}

// ── Classify ─────────────────────────────────────────────────────────

function classifyAbsPath(p) {
  // Ergatis internal scripts (BIN_DIR contents)
  const bn = basename(p);
  if (p.split('/').length <= 2) return { type: 'ergatis_script', resource: bn, note: 'Ergatis install bin/ script' };

  // TIGR/JCVI/IGS institutional paths
  if (p.match(/^\/usr\/local\/packages\//)) return { type: 'package_install', resource: p.replace(/^\/usr\/local\/packages\//, ''), note: 'TIGR /usr/local/packages — versioned software installs' };
  if (p.match(/^\/usr\/local\/devel\//)) return { type: 'package_install', resource: p.replace(/^\/usr\/local\/devel\//, ''), note: 'TIGR /usr/local/devel — development/staging installs' };
  if (p.match(/^\/usr\/local\/common\//)) return { type: 'package_install', resource: p.replace(/^\/usr\/local\/common\//, ''), note: 'TIGR /usr/local/common — shared tool symlinks' };
  if (p.match(/^\/usr\/local\/annotation\//)) return { type: 'package_install', resource: p.replace(/^\/usr\/local\/annotation\//, ''), note: 'TIGR /usr/local/annotation — annotation-specific tools/data' };
  if (p.match(/^\/usr\/local\/bioinf\//)) return { type: 'package_install', resource: p.replace(/^\/usr\/local\/bioinf\//, ''), note: 'TIGR /usr/local/bioinf — bioinformatics tools' };
  if (p.match(/^\/opt\//)) return { type: 'package_install', resource: p.replace(/^\/opt\//, ''), note: '/opt — optional packages (CloVR, QIIME, etc.)' };

  // Databases
  if (p.match(/^\/usr\/local\/db\//)) return { type: 'database', resource: p.replace(/^\/usr\/local\/db\//, ''), note: 'TIGR /usr/local/db — reference databases' };
  if (p.match(/^\/local\/db\//)) return { type: 'database', resource: p.replace(/^\/local\/db\//, ''), note: 'TIGR /local/db — local node database cache' };
  if (p.match(/^\/mnt\/staging\/data/)) return { type: 'database', resource: p.replace(/^\/mnt\/staging\/data\//, ''), note: 'CloVR staging — cloud reference data' };
  if (p.match(/data_dbs\//)) return { type: 'database', resource: p, note: 'Taxonomy/reference database' };

  // Project data (test/example paths baked into configs)
  if (p.match(/^\/local\/projects/)) return { type: 'project_data', resource: p, note: 'TIGR project-specific path — test/example data' };
  if (p.match(/^\/usr\/local\/projects/)) return { type: 'project_data', resource: p, note: 'TIGR project-specific path' };
  if (p.match(/^\/mnt\/projects/)) return { type: 'project_data', resource: p, note: 'CloVR project mount' };

  // OS/system binaries
  if (p.match(/^\/bin\/|^\/usr\/bin\//)) return { type: 'os_binary', resource: bn, note: 'System binary' };
  if (p.match(/^\/usr\/local\/bin\//)) return { type: 'os_binary', resource: bn, note: '/usr/local/bin — system-installed tool' };

  // Home dirs
  if (p.match(/^\/home\//)) return { type: 'user_path', resource: p, note: 'User home directory — should be parameterized' };

  // Special
  if (p === '/dev/null') return { type: 'os_special', resource: '/dev/null', note: 'Standard null device' };

  // Ergatis runtime/repository relative paths (workflow-internal)
  if (p.match(/^\/(workflow|output_repository)\//)) return { type: 'ergatis_runtime', resource: p, note: 'Ergatis workflow runtime path — resolved at execution' };

  // Config/data file suffixes (relative to install)
  if (p.match(/^\/(extrinsic|config)\//)) return { type: 'package_config', resource: p, note: 'Tool configuration file — relative to package install' };

  // Bare directory paths (no trailing file)
  if (p === '/usr/local/bin') return { type: 'os_binary', resource: p, note: '/usr/local/bin directory' };

  // TIGR /local/devel (without /usr prefix)
  if (p.match(/^\/local\/devel\//)) return { type: 'package_install', resource: p.replace(/^\/local\/devel\//, ''), note: 'TIGR /local/devel — development installs' };

  // URLs parsed as paths (manatee CGI)
  if (p.match(/\.(edu|org|com)\//)) return { type: 'url_fragment', resource: p, note: 'URL fragment parsed as path' };

  return { type: 'unknown', resource: p, note: 'Unclassified path' };
}

function classifyTemplateVar(v) {
  const name = v.replace(/^\{\{|\}\}$/g, '').replace(/^\$;|\$;$/g, '');
  if (name.match(/_EXEC$/)) return { type: 'tool_executable', resource: name, note: 'External tool binary — must be installed' };
  if (name.match(/_BIN$/)) return { type: 'tool_bin_dir', resource: name, note: 'Tool binary directory' };
  if (name.match(/_BIN_DIR$/)) return { type: 'tool_bin_dir', resource: name, note: 'Tool binary directory' };
  if (name.match(/_PATH$/)) return { type: 'tool_or_data_path', resource: name, note: 'Tool or data path — check component docs' };
  if (name.match(/_DIR$/)) return { type: 'directory', resource: name, note: 'Directory reference' };
  if (name.match(/_DB$/)) return { type: 'database', resource: name, note: 'Database reference' };
  if (name.match(/_LIB$/)) return { type: 'library', resource: name, note: 'Library/model directory' };
  if (name.match(/_INSTALL$/)) return { type: 'package_install', resource: name, note: 'Software installation directory' };
  if (name.match(/_HOME$/)) return { type: 'package_install', resource: name, note: 'Software home directory' };
  return { type: 'parameter', resource: name, note: 'Template variable' };
}

// ── Build resource map ───────────────────────────────────────────────

const resources = new Map(); // key → {type, resource, note, components: Set, contexts: []}

for (const ref of refs) {
  let classified;
  if (ref.source.includes('template_var')) {
    classified = classifyTemplateVar(ref.value);
  } else {
    classified = classifyAbsPath(ref.value);
  }

  const key = `${classified.type}::${classified.resource}`;
  if (!resources.has(key)) {
    resources.set(key, { ...classified, original_paths: new Set(), components: new Set(), contexts: [] });
  }
  const r = resources.get(key);
  r.original_paths.add(ref.value);
  r.components.add(ref.component);
  r.contexts.push({ component: ref.component, context: ref.context, source: ref.source });
}

// ── Generate output ──────────────────────────────────────────────────

const output = {
  description: 'Runtime resource dependency map for Ergatis components',
  generated: new Date().toISOString(),
  summary: {},
  resources: [],
};

const byType = {};
for (const [key, r] of resources) {
  const entry = {
    type: r.type,
    resource: r.resource,
    note: r.note,
    original_paths: [...r.original_paths].sort(),
    num_components: r.components.size,
    components: [...r.components].sort(),
  };
  output.resources.push(entry);
  byType[r.type] = (byType[r.type] || 0) + 1;
}

output.resources.sort((a, b) => a.type.localeCompare(b.type) || b.num_components - a.num_components);
output.summary = {
  total_resources: output.resources.length,
  by_type: byType,
  runtime_categories: {
    'ergatis_script': 'Scripts from Ergatis install bin/ directory — included with Ergatis',
    'tool_executable': 'External tool binaries referenced via template variables — must be installed separately',
    'tool_bin_dir': 'Directories containing external tool binaries',
    'tool_or_data_path': 'Paths that may reference tools or data files',
    'package_install': 'Software installation directories (TIGR institutional paths)',
    'database': 'Reference databases required at runtime',
    'os_binary': 'Standard OS/system binaries (perl, sort, mv, etc.)',
    'project_data': 'Project-specific paths baked into configs — test/example data, not runtime deps',
    'os_special': 'Standard OS special files (/dev/null)',
    'ergatis_runtime': 'Ergatis workflow runtime paths — resolved during execution',
    'package_config': 'Tool configuration files relative to package install',
    'url_fragment': 'URL fragments parsed as filesystem paths',
    'user_path': 'User home directory paths — should be parameterized',
    'directory': 'Generic directory references',
    'library': 'Library/model file directories',
    'parameter': 'Other template variable references',
  },
};

const outFile = join(root, 'data', 'resource_map.json');
writeFileSync(outFile, JSON.stringify(output, null, 2));

// ── Console summary ──────────────────────────────────────────────────

console.log(`\nResource map written to data/resource_map.json`);
console.log(`Total unique resources: ${output.resources.length}\n`);
for (const [type, count] of Object.entries(byType).sort((a, b) => b[1] - a[1])) {
  console.log(`  ${String(count).padStart(4)}  ${type}`);
}
console.log();
