#!/usr/bin/env node
// pipeline.mjs — Pipeline composition diagrams (text and optional SVG)
// Usage: node pipeline.mjs [pipeline_name] [--svg output.svg]
import { readFileSync, writeFileSync, readdirSync } from 'fs';
import { join, resolve } from 'path';

const root = resolve(import.meta.dirname, '../..');
const load = f => JSON.parse(readFileSync(join(root, f), 'utf8'));

const c = {
  reset: '\x1b[0m', bold: '\x1b[1m', dim: '\x1b[2m',
  red: '\x1b[31m', green: '\x1b[32m', yellow: '\x1b[33m',
  blue: '\x1b[34m', magenta: '\x1b[35m', cyan: '\x1b[36m',
};

const args = process.argv.slice(2);
const svgIdx = args.indexOf('--svg');
let svgOut = null;
if (svgIdx >= 0) { svgOut = args[svgIdx + 1]; args.splice(svgIdx, 2); }
const query = args[0]?.toLowerCase();

const pipelines = load('data/pipeline_catalog.json');
const biotools = load('data/biotools_mapping.json');
const btMap = {};
for (const m of biotools.mapping) { if (m.matched) btMap[m.component] = m.tool_name; }

if (!query) {
  console.log(`\n${c.bold}${c.cyan}  Available Pipeline Templates${c.reset}\n`);
  const sorted = [...pipelines].sort((a, b) => b.num_components - a.num_components);
  for (const p of sorted) {
    console.log(`  ${c.green}${p.name.padEnd(45)}${c.reset} ${c.dim}${String(p.num_components).padStart(3)} components${c.reset}`);
  }
  console.log(`\n${c.dim}  Usage: node pipeline.mjs <name> [--svg output.svg]${c.reset}\n`);
  process.exit(0);
}

const pipeline = pipelines.find(p => p.name.toLowerCase().includes(query));
if (!pipeline) { console.error(`No pipeline matching "${query}"`); process.exit(1); }

// Parse component instances: name.group format
const instances = pipeline.components.map(c => {
  const parts = c.split('.');
  return { full: c, component: parts[0], group: parts.slice(1).join('.') || null };
});

// Group by group label
const groups = {};
for (const inst of instances) {
  const g = inst.group || 'ungrouped';
  if (!groups[g]) groups[g] = [];
  groups[g].push(inst);
}

// Text output
console.log(`\n${c.bold}${c.cyan}  Pipeline: ${pipeline.name}${c.reset}`);
console.log(`${c.dim}  ${instances.length} component instances, ${Object.keys(groups).length} groups${c.reset}\n`);

let step = 0;
for (const [group, insts] of Object.entries(groups)) {
  console.log(`  ${c.bold}${c.magenta}┌─ ${group} ─${'─'.repeat(Math.max(0, 50 - group.length))}┐${c.reset}`);
  for (const inst of insts) {
    step++;
    const bt = btMap[inst.component];
    const btLabel = bt ? ` ${c.dim}[${bt}]${c.reset}` : '';
    console.log(`  ${c.magenta}│${c.reset} ${c.dim}${String(step).padStart(2)}.${c.reset} ${c.green}${inst.component}${c.reset}${btLabel}`);
  }
  console.log(`  ${c.bold}${c.magenta}└${'─'.repeat(55)}┘${c.reset}`);
  console.log(`  ${c.dim}  │${c.reset}`);
  console.log(`  ${c.dim}  ▼${c.reset}`);
}
console.log();

// SVG output
if (svgOut) {
  const boxW = 500, boxH = 32, gap = 4, groupPad = 12, margin = 20;
  let y = margin;
  const elements = [];

  const esc = s => s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
  const groupColors = ['#e8f5e9', '#e3f2fd', '#fff3e0', '#fce4ec', '#f3e5f5', '#e0f7fa', '#fff9c4'];
  let gi = 0;

  for (const [group, insts] of Object.entries(groups)) {
    const gColor = groupColors[gi++ % groupColors.length];
    const gH = groupPad * 2 + insts.length * (boxH + gap) - gap;
    elements.push(`<rect x="${margin}" y="${y}" width="${boxW}" height="${gH}" rx="6" fill="${gColor}" stroke="#ccc"/>`);
    elements.push(`<text x="${margin + 8}" y="${y + 14}" font-size="11" fill="#666" font-weight="bold">${esc(group)}</text>`);
    y += groupPad + 4;
    for (const inst of insts) {
      const bt = btMap[inst.component];
      elements.push(`<rect x="${margin + 10}" y="${y}" width="${boxW - 20}" height="${boxH}" rx="4" fill="white" stroke="#aaa"/>`);
      elements.push(`<text x="${margin + 18}" y="${y + 20}" font-size="13" font-family="monospace">${esc(inst.component)}</text>`);
      if (bt) elements.push(`<text x="${boxW - 10}" y="${y + 20}" font-size="10" fill="#888" text-anchor="end">${esc(bt)}</text>`);
      y += boxH + gap;
    }
    y += groupPad;
    // Arrow
    elements.push(`<line x1="${margin + boxW / 2}" y1="${y - groupPad + 2}" x2="${margin + boxW / 2}" y2="${y + 8}" stroke="#999" stroke-width="2" marker-end="url(#arrow)"/>`);
    y += 16;
  }

  const totalH = y + margin;
  const svg = `<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" width="${boxW + margin * 2}" height="${totalH}" viewBox="0 0 ${boxW + margin * 2} ${totalH}">
<defs><marker id="arrow" viewBox="0 0 10 10" refX="5" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse"><path d="M 0 0 L 10 5 L 0 10 z" fill="#999"/></marker></defs>
<rect width="100%" height="100%" fill="white"/>
<text x="${margin}" y="${margin - 4}" font-size="16" font-weight="bold" fill="#1a1a2e">${esc(pipeline.name)}</text>
${elements.join('\n')}
</svg>`;
  writeFileSync(svgOut, svg);
  console.log(`  ${c.green}SVG written to ${svgOut}${c.reset}\n`);
}
