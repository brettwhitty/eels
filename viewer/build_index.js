#!/usr/bin/env node
// build_index.js - Build component_index.json for the web viewer
// Combines component JSON, categorized steps, biotools mapping, and EDAM mapping
const fs = require('fs');
const path = require('path');

const eels = path.resolve(__dirname, '..');
const outFile = path.join(__dirname, 'component_index.json');

// Load all component JSON files
const compDir = path.join(eels, 'data', 'components');
const components = {};
for (const f of fs.readdirSync(compDir).filter(f => f.endsWith('.json')).sort()) {
  const name = f.replace('.json', '');
  components[name] = JSON.parse(fs.readFileSync(path.join(compDir, f), 'utf8'));
}

// Load categorized steps
const stepsDir = path.join(eels, 'data', 'categorized_steps');
const steps = {};
for (const f of fs.readdirSync(stepsDir).filter(f => f.endsWith('.json')).sort()) {
  const name = f.replace('.json', '');
  steps[name] = JSON.parse(fs.readFileSync(path.join(stepsDir, f), 'utf8'));
}

// Load biotools mapping
const biotools = {};
try {
  const bt = JSON.parse(fs.readFileSync(path.join(eels, 'data', 'biotools_mapping.json'), 'utf8'));
  for (const m of (bt.mapping || [])) {
    if (m.matched) {
      biotools[m.component] = { id: m.biotoolsID, name: m.tool_name, url: m.bio_tools_url };
    }
  }
} catch(e) { console.warn('biotools_mapping.json not found'); }

// Load EDAM mapping
const edam = {};
try {
  const ed = JSON.parse(fs.readFileSync(path.join(eels, 'data', 'edam_mapping.json'), 'utf8'));
  for (const m of (ed.mapping || [])) {
    edam[m.component] = { operations: m.edam_operations || [], topics: m.edam_topics || [] };
  }
} catch(e) { console.warn('edam_mapping.json not found'); }

const index = { components, steps, biotools, edam, generated: new Date().toISOString() };
fs.writeFileSync(outFile, JSON.stringify(index));

const size = (fs.statSync(outFile).size / 1024 / 1024).toFixed(1);
console.log(`Built ${outFile}`);
console.log(`  ${Object.keys(components).length} components, ${Object.keys(steps).length} step files`);
console.log(`  ${Object.keys(biotools).length} biotools mappings, ${Object.keys(edam).length} EDAM mappings`);
console.log(`  Size: ${size} MB`);
