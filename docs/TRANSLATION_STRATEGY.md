# EELS Multi-Format Translation Strategy

## Three-Tier Representation

### Tier 1: Ergatis Lite (Minimal)
**Purpose:** Compact, human-readable workflow structure  
**Use case:** Quick reference, command-line composition, workflow sketching

**Format:**
```
(
  <split_fasta:input=genome.fsa>,
  {
    <blast:database=/db/nr.fasta:evalue=1e-5>,
    <hmmpfam:database=/db/Pfam.hmm>
  },
  <merge_annotations>
)
```

**Captures:**
- Component ordering (serial/parallel)
- Minimal I/O (input files, output destinations)
- Required databases and reference assemblies
- Essential parameters (e-value, thresholds)
- Default settings for common use cases

**Benefits:**
- Minimal syntax (mathematical notation)
- One-liner capable
- Easy to read and modify
- Natural representation of Ergatis structure

### Tier 2: CWL (Component Configuration)
**Purpose:** Capture individual tool configurations and parameters  
**Use case:** Tool-level parameter documentation, type validation

**Format:**
```yaml
cwlVersion: v1.2
class: CommandLineTool
baseCommand: [blastp]
inputs:
  query:
    type: File
    inputBinding:
      prefix: -query
  database:
    type: string
    default: /db/nr.fasta
    inputBinding:
      prefix: -db
  evalue:
    type: float
    default: 1e-5
    inputBinding:
      prefix: -evalue
outputs:
  alignments:
    type: File
    outputBinding:
      glob: "*.raw"
```

**Captures:**
- Individual tool parameters (not multi-step workflows)
- Type definitions (File, string, int, float, etc.)
- Default values and flags
- Input/output bindings for single tools
- Tool-specific requirements

**Scope:**
- ONE tool per CWL file
- Component configs → multiple CWL CommandLineTools
- Multi-step execution → Ergatis Lite or BCO, NOT CWL Workflow

**Benefits:**
- Type safety for tool parameters
- Validation of individual tool configs
- Reusable tool definitions

### Tier 3: BioCompute Object (Documentation)
**Purpose:** Regulatory compliance, provenance, full documentation  
**Use case:** FDA submissions, publication, long-term preservation

**Format:**
```json
{
  "object_id": "https://example.org/bco/blast_annotation",
  "spec_version": "1.4.0",
  "provenance_domain": {
    "name": "BLAST Protein Annotation Pipeline",
    "version": "1.0",
    "created": "2024-01-01T00:00:00Z",
    "modified": "2024-01-01T00:00:00Z",
    "contributors": [
      {
        "name": "Brett Whitty",
        "affiliation": "TIGR",
        "contribution": ["createdBy"]
      }
    ],
    "license": "Artistic-2.0"
  },
  "usability_domain": [
    "Protein sequence annotation using BLAST against nr database",
    "Identifies homologous proteins and transfers functional annotations"
  ],
  "description_domain": {
    "keywords": ["alignment", "protein", "BLAST", "annotation"],
    "pipeline_steps": [
      {
        "step_number": 1,
        "name": "BLAST protein alignment",
        "description": "Run NCBI BLASTP against nr database",
        "version": "2.2.26",
        "input_list": [
          {"uri": "query.fasta"}
        ],
        "output_list": [
          {"uri": "blast.raw"}
        ]
      }
    ]
  },
  "parametric_domain": [
    {
      "param": "evalue",
      "value": "1e-5",
      "step": "1"
    },
    {
      "param": "database",
      "value": "/db/nr.fasta",
      "step": "1"
    }
  ],
  "io_domain": {
    "input_subdomain": [
      {
        "uri": {
          "filename": "query.fasta",
          "uri": "file:///input/query.fasta"
        }
      }
    ],
    "output_subdomain": [
      {
        "mediatype": "application/xml",
        "uri": {
          "filename": "blast.bsml",
          "uri": "file:///output/blast.bsml"
        }
      }
    ]
  },
  "execution_domain": {
    "script": [
      {"uri": "https://example.org/blast_component.xml"}
    ],
    "script_driver": "TIGR Workflow Engine",
    "software_prerequisites": [
      {
        "name": "NCBI BLAST+",
        "version": "2.2.26",
        "uri": "https://blast.ncbi.nlm.nih.gov/"
      }
    ],
    "environment_variables": {
      "BLASTDB": "/db"
    }
  }
}
```

**Captures:**
- Complete provenance (who, when, why)
- Full parameter documentation
- Tool versions and dependencies
- Environment requirements
- Error handling strategies
- Validation criteria
- Human-readable descriptions
- Regulatory compliance metadata

**Benefits:**
- IEEE 2791-2020 standard
- FDA submission ready
- Complete documentation
- Provenance tracking
- Long-term preservation

## Translation Workflow

### From Ergatis Component

**Important:** Ergatis components contain multi-step execution (tool + converters + validation). This multi-step nature is captured in Ergatis Lite and BCO, NOT in CWL.

1. **Extract to Ergatis Lite:**
   - Parse component XML (full multi-step execution)
   - Identify serial/parallel structure
   - Extract required databases from `.config`
   - Document default parameters
   - Create minimal notation showing ALL steps

2. **Generate CWL (per tool):**
   - ONE CWL file per tool in component
   - Map tool executable to `baseCommand`
   - Extract parameters from `.config` → CWL inputs
   - Define types (File, string, int, float)
   - Add requirements (Docker, resources)
   - **DO NOT** create CWL Workflow for multi-step component

3. **Generate BCO:**
   - Capture full multi-step execution in pipeline_steps
   - Extract provenance from git history
   - Map contributors from `CONTRIBUTORS.md`
   - Document tool versions from production
   - Create execution domain from component XML (all steps)
   - Add parametric domain from `.config`
   - Build I/O domain from input/output specs

### Example: BLAST Component (Multi-Step)

**Ergatis Component Structure:**
1. Run BLAST (tool)
2. Convert to BTAB (converter)
3. Convert to BSML (converter)
4. Validate BSML (validation)

**Ergatis Lite (captures all steps):**
```
(
  <blast:query=$INPUT:database=/db/nr.fasta:evalue=1e-5>,
  <blast2btab:input=blast.raw:output=blast.btab>,
  <blast2bsml:input=blast.raw:output=blast.bsml>,
  <validate:input=blast.bsml>
)
```

**CWL (one per tool, NOT workflow):**
- `blast.cwl` - BLAST tool only
- `blast2btab.cwl` - Converter tool only
- `blast2bsml.cwl` - Converter tool only
- `validate.cwl` - Validation tool only

**BCO (captures full multi-step execution):**
```json
{
  "description_domain": {
    "pipeline_steps": [
      {
        "step_number": 1,
        "name": "BLAST protein alignment",
        "description": "Run NCBI BLASTP"
      },
      {
        "step_number": 2,
        "name": "Convert to BTAB",
        "description": "Parse BLAST raw to tabular format"
      },
      {
        "step_number": 3,
        "name": "Convert to BSML",
        "description": "Parse BLAST raw to BSML XML"
      },
      {
        "step_number": 4,
        "name": "Validate BSML",
        "description": "DTD validation of BSML output"
      }
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

1. **Phase 1:** Extract Ergatis Lite notation for all 362 components
2. **Phase 2:** Generate CWL for 10-20 representative components
3. **Phase 3:** Create BCO templates for common component types
4. **Phase 4:** Full BCO generation for complete workflows
5. **Phase 5:** Validation and testing

## Benefits of Multi-Format Approach

- **Ergatis Lite:** Preserves original design philosophy (minimal, mathematical), captures multi-step execution
- **CWL:** Documents individual tool parameters with type safety (NOT for multi-step workflows)
- **BCO:** Ensures regulatory compliance, captures full multi-step execution, long-term preservation
- **Together:** Complete knowledge transfer - Ergatis Lite and BCO for workflows, CWL for tool configs

## References

- Ergatis Lite: `docs/ERGATIS_LITE_SPEC.md`
- CWL: https://www.commonwl.org/
- BCO: https://docs.biocomputeobject.org/
- IEEE 2791-2020: BioCompute Object Standard
