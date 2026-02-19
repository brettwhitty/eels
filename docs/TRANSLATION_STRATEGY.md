# EELS Multi-Format Translation Strategy

## Primary Format: Component JSON

**Source:** `data/components/*.json` (362 files from dev-component project, 2017)

**Example:** `data/components/aat_na.json`
```json
{
  "name": "aat_na",
  "classification": "alignment / pairwise",
  "tool_execution": [
    {"name": "dds", "executable": "$;DDS_EXEC$;"},
    {"name": "ext", "executable": "$;EXT_EXEC$;"},
    {"name": "filter", "executable": "$;FILTER_EXEC$;"}
  ],
  "converters": {
    "iterator": [
      {"script": "gap22bsml", "input": "*.btab", "output": "*.bsml"}
    ]
  },
  "output_formats": ["bsml_output_list", "btab_output_list"],
  "has_iterator": true,
  "group_count": "150"
}
```

**This is the canonical representation.** All other formats are derived from this.

## Derived Formats

### Tier 1: Ergatis Lite (Minimal Notation)
**Purpose:** Compact, human-readable representation  
**Derived from:** Component JSON

**Format:**
```
(
  <dds:executable=$;DDS_EXEC$;>,
  <ext:executable=$;EXT_EXEC$;>,
  <filter:executable=$;FILTER_EXEC$;>,
  <gap22bsml:input=*.btab:output=*.bsml>
)
```

**Captures:**
- Component execution order (from `tool_execution` array)
- Converter chain (from `converters` object)
- Minimal parameters
- Serial/parallel structure

### Tier 2: CWL (Tool Parameter Documentation)
**Purpose:** Type-safe parameter documentation for individual tools  
**Derived from:** Component JSON `tool_execution` entries

**Scope:** ONE CWL file per tool in `tool_execution` array

**Example:** From `aat_na.json` → generate `dds.cwl`, `ext.cwl`, `filter.cwl`

```yaml
# dds.cwl
cwlVersion: v1.2
class: CommandLineTool
baseCommand: [$DDS_EXEC]
inputs:
  query:
    type: File
  database:
    type: File
outputs:
  raw_output:
    type: File
```

**Does NOT capture:**
- Multi-step execution (that's in Component JSON)
- Converter chains (that's in Component JSON)
- Workflow composition (that's in Component JSON)

### Tier 3: BioCompute Object (Regulatory Documentation)
**Purpose:** IEEE 2791-2020 standard for regulatory compliance  
**Derived from:** Component JSON + CONTRIBUTORS.md + git history

**Format:**
```json
{
  "provenance_domain": {
    "name": "AAT Nucleotide Alignment",
    "contributors": [/* from CONTRIBUTORS.md */]
  },
  "description_domain": {
    "pipeline_steps": [
      {"step_number": 1, "name": "dds"},
      {"step_number": 2, "name": "ext"},
      {"step_number": 3, "name": "filter"},
      {"step_number": 4, "name": "gap22bsml"}
    ]
  },
  "parametric_domain": [/* from component .config */],
  "io_domain": {
    "output_subdomain": [
      {"mediatype": "application/xml", "uri": "*.bsml"}
    ]
  }
}
```

**Captures:**
- Full multi-step execution (from `tool_execution` + `converters`)
- Provenance and attribution
- Complete parameter documentation
- Regulatory compliance metadata

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

## Implementation Plan

1. **Phase 1:** Component JSON is already complete (362 files, 2017)
2. **Phase 2:** Generate Ergatis Lite notation from Component JSON
3. **Phase 3:** Generate CWL CommandLineTools from Component JSON `tool_execution` arrays
4. **Phase 4:** Generate BCO from Component JSON + CONTRIBUTORS.md + .config files
5. **Phase 5:** Validation and testing

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
