# EELS Multi-Format Translation Strategy

## Data Hierarchy

### Level 1: Components (362 files)
**Source:** `data/components/*.json`  
**Scope:** Individual atomic workflow units  
**Captures:** Tool execution chains, converters, parameters within ONE component

**Example:** `aat_na.json`
```json
{
  "name": "aat_na",
  "tool_execution": [
    {"name": "dds", "executable": "$;DDS_EXEC$;"},
    {"name": "ext", "executable": "$;EXT_EXEC$;"}
  ],
  "converters": {
    "iterator": [
      {"script": "gap22bsml", "input": "*.btab", "output": "*.bsml"}
    ]
  }
}
```

### Level 2: Workflows (56 workflows, 108 XML files)
**Source:** `ergatis-git/workflow/` (XML templates)  
**Current catalog:** `data/workflow_catalog.json` (file counts only)  
**Scope:** Component composition and ordering  
**Captures:** Which components run in what order, data flow between components

**NOT YET EXTRACTED:** Actual workflow logic (component ordering, data dependencies)

**Example workflow structure:**
```
Prokaryotic Annotation Pipeline:
1. glimmer3 (gene prediction)
2. blast (protein alignment)
3. hmmpfam (domain search)
4. merge_annotations (combine results)
5. bsml2chado (database load)
```

### Level 3: Converters (65 files)
**Source:** `data/converters/*.json` (from manpages)  
**Scope:** Tool output → BSML transformation  
**Captures:** Converter parameters, input/output formats

## Translation Targets

### For Components: Ergatis Lite + CWL + BCO

**Component JSON → Ergatis Lite:**
```
(<dds>, <ext>, <filter>, <gap22bsml>)
```

**Component JSON → CWL (one per tool):**
- `dds.cwl` - individual tool config
- `ext.cwl` - individual tool config
- `gap22bsml.cwl` - individual tool config

**Component JSON → BCO:**
```json
{
  "pipeline_steps": [
    {"step_number": 1, "name": "dds"},
    {"step_number": 2, "name": "ext"}
  ]
}
```

### For Workflows: Ergatis Lite + BCO ONLY

**Workflow XML → Ergatis Lite:**
```
(
  <glimmer3:input=genome.fsa>,
  {<blast:database=/db/nr>, <hmmpfam:database=/db/Pfam>},
  <merge_annotations>,
  <bsml2chado>
)
```

**Workflow XML → BCO:**
```json
{
  "pipeline_steps": [
    {"step_number": 1, "name": "glimmer3 gene prediction"},
    {"step_number": 2, "name": "blast alignment", "prerequisite": [1]},
    {"step_number": 3, "name": "hmmpfam domains", "prerequisite": [1]},
    {"step_number": 4, "name": "merge", "prerequisite": [2, 3]},
    {"step_number": 5, "name": "load to chado", "prerequisite": [4]}
  ]
}
```

**Why Ergatis Lite + BCO for workflows?**
- Ergatis Lite: Captures the hierarchical composition (serial/parallel/component nesting)
- BCO: Captures provenance, parameters, and regulatory compliance
- CWL: Used for individual tool configs only

## Translation Workflow

### From Component JSON (Primary Source)

**Input:** `data/components/*.json` (362 files)

1. **Generate Ergatis Lite:**
   - Read `tool_execution` array → serial execution steps
   - Read `converters` object → converter chain
   - Extract parameters from component `.config` files
   - Create minimal notation

2. **Generate CWL (per tool):**
   - For each entry in `tool_execution` array:
     - Create ONE CWL CommandLineTool file
     - Map `executable` to `baseCommand`
     - Extract parameters from `.config`
     - Define input/output types
   - Result: Multiple CWL files per component

3. **Generate BCO:**
   - Map `tool_execution` array → `pipeline_steps`
   - Map `converters` → additional pipeline steps
   - Add provenance from `CONTRIBUTORS.md`
   - Add parameters from `.config` files
   - Build I/O domain from `output_formats`
   - Result: One BCO per component

### Example: aat_na Component

**Source:** `data/components/aat_na.json`

**Generated Ergatis Lite:**
```
(
  <dds:executable=$;DDS_EXEC$;>,
  <ext:executable=$;EXT_EXEC$;>,
  <filter:executable=$;FILTER_EXEC$;>,
  <gap22bsml:input=*.btab:output=*.bsml>
)
```

**Generated CWL files:**
- `dds.cwl` (from tool_execution[0])
- `ext.cwl` (from tool_execution[1])
- `filter.cwl` (from tool_execution[2])
- `gap22bsml.cwl` (from converters.iterator[0])

**Generated BCO:**
```json
{
  "description_domain": {
    "pipeline_steps": [
      {"step_number": 1, "name": "dds"},
      {"step_number": 2, "name": "ext"},
      {"step_number": 3, "name": "filter"},
      {"step_number": 4, "name": "gap22bsml"}
    ]
  }
}
```

## Use Cases

### Tool Parameter Documentation
→ Use CWL CommandLineTool for individual tools

### Multi-Step Component Documentation
→ Use Ergatis Lite notation

### Workflow Execution
→ Use Ergatis Lite or BCO (NOT CWL Workflow)

### Regulatory Submission
→ Use BCO for FDA compliance

### Publication
→ Include all three formats for completeness

### Long-term Preservation
→ BCO as primary format, CWL for tool configs, Ergatis Lite for human readability

## Current Status

### Complete
- ✅ Component JSON (362 files) - individual component structure
- ✅ Converter JSON (65 files) - converter parameters
- ✅ Workflow catalog (56 workflows) - file counts only

### Incomplete
- ❌ Workflow logic extraction - component ordering, data flow
- ❌ Workflow JSON - structured representation of pipelines
- ❌ Ergatis Lite generation
- ❌ CWL generation
- ❌ BCO generation

## Next Steps

1. **Parse workflow XML files** - Extract component ordering and data dependencies
2. **Create workflow JSON** - Structured representation of 56 workflows
3. **Generate Ergatis Lite** - For components and workflows
4. **Generate CWL** - For individual tools only
5. **Generate BCO** - For components and workflows

## Benefits of Multi-Format Approach

- **Component JSON:** Primary canonical format (already complete, 362 components)
- **Ergatis Lite:** Human-readable minimal notation derived from JSON
- **CWL:** Type-safe tool parameter documentation (one per tool in component)
- **BCO:** Regulatory compliance, full provenance, IEEE standard
- **Together:** Complete knowledge preservation with multiple access points

## References

- Ergatis Lite: `docs/ERGATIS_LITE_SPEC.md`
- CWL: https://www.commonwl.org/
- BCO: https://docs.biocomputeobject.org/
- IEEE 2791-2020: BioCompute Object Standard
