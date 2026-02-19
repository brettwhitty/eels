// tools/node/lib/display.mjs — Shared terminal display library for EELS tools
import chalk from 'chalk';
import boxen from 'boxen';
import Table from 'cli-table3';

// ── Box ──────────────────────────────────────────────────────────────
export function box(title, subtitle, opts = {}) {
  const content = subtitle
    ? `${chalk.bold(title)}\n${chalk.dim(subtitle)}`
    : chalk.bold(title);
  return boxen(content, {
    padding: { left: 2, right: 2, top: 0, bottom: 0 },
    borderColor: 'cyan',
    borderStyle: 'double',
    ...opts,
  });
}

// ── Section header ───────────────────────────────────────────────────
export function header(text, width = 80) {
  return `\n${chalk.bold.bgBlue.white(` ${text.padEnd(width - 1)} `)}`;
}

// ── Bar chart ────────────────────────────────────────────────────────
export function bar(n, max, width = 30) {
  const filled = Math.round((n / max) * width);
  return chalk.green('█'.repeat(filled)) + chalk.dim('░'.repeat(width - filled));
}

export function colorBar(n, max, width = 30, color = 'green') {
  const filled = Math.round((n / max) * width);
  return chalk[color]('█'.repeat(filled)) + chalk.dim('░'.repeat(width - filled));
}

// ── Labeled bar line ─────────────────────────────────────────────────
export function barLine(label, n, max, opts = {}) {
  const { labelWidth = 22, barWidth = 30, color, showTotal = true } = opts;
  const pct = Math.round((n / max) * 100);
  const barColor = color || (pct >= 90 ? 'green' : pct >= 50 ? 'yellow' : 'red');
  const total = showTotal ? `/${max}` : '';
  return `  ${label.padEnd(labelWidth)} ${colorBar(n, max, barWidth, barColor)} ${String(n).padStart(4)}${total} ${chalk.dim(`(${pct}%)`)}`;
}

// ── Stat line ────────────────────────────────────────────────────────
export function stat(n, label, color = 'green') {
  return `  ${chalk.bold[color](String(n).padStart(5))} ${label}`;
}

// ── Table ────────────────────────────────────────────────────────────
export function table(headers, rows, opts = {}) {
  const t = new Table({
    head: headers.map(h => chalk.bold(h)),
    style: { head: [], border: ['dim'] },
    ...opts,
  });
  for (const row of rows) t.push(row);
  return t.toString();
}

// ── Tree rendering ───────────────────────────────────────────────────
export function treeNode(label, count, isLast, depth = 0) {
  const prefix = depth === 0
    ? (isLast ? '└' : '├')
    : (isLast ? '└' : '├');
  const indent = depth === 0 ? '  ' : '  │  ';
  return `${indent}${chalk.dim(prefix)}── ${chalk.bold.green(label)} ${chalk.dim(`(${count})`)}`;
}

export function treeChild(label, count, items, isLast, parentLast) {
  const childPrefix = parentLast ? ' ' : '│';
  const sp = isLast ? '└' : '├';
  const sample = items.slice(0, 3).join(', ');
  const more = items.length > 3 ? ` +${items.length - 3}` : '';
  return `  ${chalk.dim(childPrefix)}  ${chalk.dim(sp)}── ${chalk.blue(label)} ${chalk.dim(`(${count})`)} ${chalk.yellow(sample)}${chalk.dim(more)}`;
}

export function treeLeaf(items, parentLast, max = 5) {
  const childPrefix = parentLast ? ' ' : '│';
  const sample = items.slice(0, max).join(', ');
  const more = items.length > max ? `, ${chalk.dim(`+${items.length - max} more`)}` : '';
  return `  ${chalk.dim(childPrefix)}   ${chalk.yellow(sample)}${more}`;
}

// ── Pipeline diagram ─────────────────────────────────────────────────
export function pipelineGroup(groupName, steps, width = 55) {
  const border = '─'.repeat(Math.max(0, width - groupName.length));
  let out = `  ${chalk.bold.magenta(`┌─ ${groupName} ─${border}┐`)}\n`;
  for (const { num, name, annotation } of steps) {
    const ann = annotation ? ` ${chalk.dim(`[${annotation}]`)}` : '';
    out += `  ${chalk.magenta('│')} ${chalk.dim(String(num).padStart(2) + '.')} ${chalk.green(name)}${ann}\n`;
  }
  out += `  ${chalk.bold.magenta(`└${'─'.repeat(width + 2)}┘`)}\n`;
  out += `  ${chalk.dim('  │')}\n`;
  out += `  ${chalk.dim('  ▼')}`;
  return out;
}

// ── Component detail ─────────────────────────────────────────────────
export function componentHeader(name, classification, biotools, edam) {
  let out = `  ${chalk.bold.green(name)} ${chalk.dim(`— ${classification || 'unclassified'}`)}`;
  if (biotools) out += `\n    ${chalk.blue('bio.tools:')} ${biotools.name} ${chalk.dim(`(${biotools.url})`)}`;
  if (edam) {
    if (edam.operations?.length) out += `\n    ${chalk.magenta('EDAM ops:')} ${edam.operations.join(', ')}`;
    if (edam.topics?.length) out += `\n    ${chalk.magenta('EDAM topics:')} ${edam.topics.join(', ')}`;
  }
  return out;
}

// ── Divider ──────────────────────────────────────────────────────────
export function divider(width = 72) {
  return chalk.dim('─'.repeat(width));
}

// Re-export chalk for direct use
export { chalk };
