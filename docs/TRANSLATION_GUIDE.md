# EELS Translation Guide

## Overview

This guide documents how Ergatis knowledge is translated into three complementary formats:
1. **Ergatis Lite** - Minimal mathematical notation
2. **CWL** - Individual tool configurations
3. **BCO** - IEEE 2791-2020 regulatory compliance

## Source Data

### Component JSON (Primary)
**Location:** `data/components/*.json` (362 files)

**Structure:**
```json
{
  "name": "ncbi-blastp",
  "classification": "alignment / pairwise",
  "tool_execution": [
    {"name": "ncbi-blastp", "executable": "$;BLASTALL_EXEC$;"}
  ],
  "converters": {
    "iterator": [
      {"script": "blast2btab", "input": "*.raw", "output": "*.btab"},
      {"script": "blast2bsml", "input": "*.raw", "output": "*.bsml"}
    ]
  },
  "output_formats": ["bsml", "btab", "raw"]
}
```

### Workflow Structure JSON
**Location:** `data/workflow_structure.json`

**Structure:**
```json
{
  "pangenome": {
    "steps": [
      {"type": "command", "name": "Parse genome BSML", "level": 1},
      {"type": "commandSet", "execution": "parallel", "level": 1}
    ]
  }
}
```

## Translation Outputs

### 1. Ergatis Lite Notation

**Purpose:** Minimal human-readable representation of hierarchical composition

**Location:** `data/ergatis_lite/*.lite` (362 files)

**Example:** `ncbi-blastp.lite`
```
<ncbi-blastp> = (
  <create output directory>,
  <ncbi-blastp>,
  <dtd validation>,
  <blast2btab>,
  <blast2bsml>,
  <analysis2bsml>
)
```

**Syntax:**
- `()` = Serial execution (ordered list)
- `{}` = Parallel execution (unordered set)
- `<name>` = Component or tool reference
- `,` = Sequence separator

**Captures:**
- Multi-step execution within component
- Tool → converter chains
- Serial composition

**Does NOT capture:**
- Detailed parameters
- Type information
- Execution environment

### 2. CWL CommandLineTool

**Purpose:** Type-safe tool parameter documentation

**Location:** `data/cwl/*.cwl`

**Example:** `ncbi-blastp_ncbi_blastp.cwl`
```yaml
cwlVersion: v1.2
class: CommandLineTool
id: ncbi-blastp_ncbi_blastp
label: ncbi-blastp from ncbi-blastp component
baseCommand: [ncbi-blastp]
inputs:
  input_file:
    type: File
    inputBinding:
      position: 1
  database:
    type: string
    inputBinding:
      prefix: -d
  evalue:
    type: float
    default: 1e-5
    inputBinding:
      prefix: -e
outputs:
  alignments:
    type: File
    outputBinding:
      glob: "*.raw"
```

**Scope:**
- ONE CWL file per tool in `tool_execution` array
- Individual tool parameters only
- NOT for multi-step component execution
- NOT for workflow composition

**Captures:**
- Tool executable
- Input/output types
- Parameter flags and defaults
- File glob patterns

### 3. BioCompute Object (BCO)

**Purpose:** IEEE 2791-2020 regulatory compliance and complete documentation

**Location:** `data/bco/*.json`

**Example:** `ncbi-blastp.json`
```json
{
  "object_id": "https://example.org/bco/ergatis/ncbi-blastp",
  "spec_version": "1.4.0",
  "provenance_domain": {
    "name": "Ergatis ncbi-blastp Component",
    "version": "1.0",
    "created": "2003-01-01T00:00:00Z",
    "contributors": [
      {
        "name": "TIGR/JCVI/IGS Bioinformatics Team",
        "affiliation": "The Institute for Genomic Research",
        "contribution": ["createdBy"]
      }
    ],
    "license": "Artistic-2.0"
  },
  "usability_domain": [
    "BLAST protein alignment component",
    "Production-grade genome annotation from TIGR Gold-Standard pipelines"
  ],
  "description_domain": {
    "keywords": ["alignment", "pairwise", "protein"],
    "pipeline_steps": [
      {
        "step_number": 1,
        "name": "ncbi-blastp",
        "description": "Execute NCBI BLASTP",
        "prerequisite": []
      },
      {
        "step_number": 2,
        "name": "blast2btab",
        "description": "Convert to tabular format",
        "prerequisite": [1]
      },
      {
        "step_number": 3,
        "name": "blast2bsml",
        "description": "Convert to BSML XML",
        "prerequisite": [1]
      }
    ]
  },
  "execution_domain": {
    "script": [{"uri": "ergatis://component/ncbi-blastp"}],
    "script_driver": "TIGR Workflow Engine",
    "software_prerequisites": [
      {"name": "NCBI BLAST+", "version": "2.2.26"}
    ]
  },
  "parametric_domain": [
    {"param": "evalue", "value": "1e-5", "step": "1"},
    {"param": "database", "value": "/db/nr.fasta", "step": "1"}
  ],
  "io_domain": {
    "input_subdomain": [
      {"uri": {"filename": "query.fasta"}}
    ],
    "output_subdomain": [
      {"mediatype": "application/xml", "uri": {"filename": "blast.bsml"}},
      {"mediatype": "text/plain", "uri": {"filename": "blast.btab"}}
    ]
  }
}
```

**Captures:**
- Complete multi-step execution
- Provenance and attribution
- Tool versions and dependencies
- Parameter documentation
- Input/output specifications
- Regulatory compliance metadata

## Translation Workflow

### From Component JSON

1. **Generate Ergatis Lite:**
   ```python
   steps = []
   for tool in component['tool_execution']:
       steps.append(f"<{tool['name']}>")
   for conv in component['converters']['iterator']:
       steps.append(f"<{conv['script']}>")
   notation = f"<{name}> = (\n  " + ",\n  ".join(steps) + "\n)"
   ```

2. **Generate CWL (per tool):**
   ```python
   for tool in component['tool_execution']:
       cwl = {
           'cwlVersion': 'v1.2',
           'class': 'CommandLineTool',
           'baseCommand': [tool['executable']],
           'inputs': {...},
           'outputs': {...}
       }
       write_cwl(f"{component_name}_{tool_name}.cwl", cwl)
   ```

3. **Generate BCO:**
   ```python
   bco = {
       'provenance_domain': extract_provenance(),
       'description_domain': {
           'pipeline_steps': build_steps_from_tools_and_converters()
       },
       'execution_domain': extract_execution_env(),
       'io_domain': extract_io_from_formats()
   }
   ```

### From Workflow Structure JSON

1. **Generate Ergatis Lite:**
   ```
   (
     <component1>,
     {<component2>, <component3>},  # parallel
     <component4>
   )
   ```

2. **Generate BCO:**
   - Map workflow steps to BCO pipeline_steps
   - Add component-level dependencies
   - Include workflow-level provenance

## Use Cases

### Quick Reference
→ Ergatis Lite notation

### Tool Parameter Documentation
→ CWL CommandLineTool files

### Multi-Step Component Documentation
→ Ergatis Lite + BCO

### Workflow Composition
→ Ergatis Lite + BCO (NOT CWL)

### Regulatory Submission
→ BCO (IEEE 2791-2020 standard)

### Long-Term Preservation
→ All three formats for completeness

## Format Comparison

| Feature | Ergatis Lite | CWL | BCO |
|---------|-------------|-----|-----|
| **Scope** | Component/Workflow | Individual Tool | Component/Workflow |
| **Multi-step** | ✓ | ✗ | ✓ |
| **Type Safety** | ✗ | ✓ | ✗ |
| **Provenance** | ✗ | ✗ | ✓ |
| **Executable** | ✗ | ✓ | ✗ |
| **Human Readable** | ✓✓ | ✓ | ✓ |
| **Regulatory** | ✗ | ✗ | ✓ |
| **Hierarchical** | ✓ | ✗ | ✓ |

## Implementation Status

### Completed
- ✓ Component JSON extraction (362 components)
- ✓ Workflow structure extraction (51 workflows)
- ✓ Ergatis Lite generation (362 components)
- ✓ CWL samples (4 tools)
- ✓ BCO samples (5 components)

### In Progress
- Complete BCO generation for all components
- Workflow-level Ergatis Lite notation
- Complete CWL tool definitions

### Future
- BCO workflow-level objects
- Validation against IEEE 2791-2020 schema
- Translation tooling automation

## References

- Component JSON: `data/components/README.md`
- Ergatis Architecture: `docs/ERGATIS_ARCHITECTURE.md`
- Ergatis Lite Spec: `docs/ERGATIS_LITE_SPEC.md`
- BCO Mapping: `docs/BCO_MAPPING.md`
- Translation Strategy: `docs/TRANSLATION_STRATEGY.md`
