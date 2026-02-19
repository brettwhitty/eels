#!/usr/bin/env node
// pipeline.mjs — Pipeline composition diagrams (text and optional SVG)
// Usage: node pipeline.mjs [pipeline_name] [--svg output.svg]
import { writeFileSync } from 'fs';
import { pipelineGroup, chalk } from './lib/display.mjs';
import { getPipelines, getBiotools, getPipelineDetail } from './lib/data.mjs';

const args = process.argv.slice(2);
const svgIdx = args.indexOf('--svg');
let svgOut = null;
if (svgIdx >= 0) { svgOut = args[svgIdx + 1]; args.splice(svgIdx, 2); }
const query = args[0]?.toLowerCase();

const { map: btMap } = getBiotools();

if (!query) {
  const pipelines = getPipelines();
  console.log(`\n${chalk.bold.cyan('  Available Pipeline Templates')}\n`);
  for (const p of [...pipelines].sort((a, b) => b.num_components - a.num_components)) {
    console.log(`  ${chalk.green(p.name.padEnd(45))} ${chalk.dim(String(p.num_components).padStart(3) + ' components')}`);
  }
  console.log(`\n${chalk.dim('  Usage: node pipeline.mjs <name> [--svg output.svg]')}\n`);
  process.exit(0);
}

const detail = getPipelineDetail(query);
if (!detail) { console.error(`No pipeline matching "${query}"`); process.exit(1); }
const { pipeline, instances, groups } = detail;

console.log(`\n${chalk.bold.cyan(`  Pipeline: ${pipeline.name}`)}`);
console.log(chalk.dim(`  ${instances.length} component instances, ${Object.keys(groups).length} groups\n`));

let step = 0;
for (const [group, insts] of Object.entries(groups)) {
  const steps = insts.map(inst => ({
    num: ++step,
    name: inst.component,
    annotation: btMap[inst.component]?.name || null,
  }));
  console.log(pipelineGroup(group, steps));
}
console.log();

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
      if (bt) elements.push(`<text x="${boxW - 10}" y="${y + 20}" font-size="10" fill="#888" text-anchor="end">${esc(bt.name)}</text>`);
      y += boxH + gap;
    }
    y += groupPad;
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
  console.log(`  ${chalk.green(`SVG written to ${svgOut}`)}\n`);
}
