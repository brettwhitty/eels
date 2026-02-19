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

### Tier 2: CWL (Executable)
**Purpose:** Full workflow execution specification  
**Use case:** Running workflows, parameter validation, type checking

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
- Complete parameter spaces
- Type definitions (File, string, int, float, etc.)
- Default values and flags
- Input/output bindings
- Requirements (Docker, environment, resources)
- Scatter/gather patterns (from iterators)

**Benefits:**
- Executable workflows
- Type safety
- Tool validation
- Portable across CWL runners

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

1. **Extract to Ergatis Lite:**
   - Parse component XML
   - Identify serial/parallel structure
   - Extract required databases from `.config`
   - Document default parameters
   - Create minimal notation

2. **Generate CWL:**
   - Map tool executables to `baseCommand`
   - Extract parameters from `.config` → CWL inputs
   - Define types (File, string, int, float)
   - Map iterator patterns → scatter
   - Add requirements (Docker, resources)

3. **Generate BCO:**
   - Extract provenance from git history
   - Map contributors from `CONTRIBUTORS.md`
   - Document tool versions from production
   - Create execution domain from component XML
   - Add parametric domain from `.config`
   - Build I/O domain from input/output specs

### Example: BLAST Component

**Ergatis Lite:**
```
<blast:query=$INPUT:database=/db/nr.fasta:evalue=1e-5:output=$OUTPUT>
```

**CWL:** (see Tier 2 example above)

**BCO:** (see Tier 3 example above)

## Use Cases

### Quick Reference
→ Use Ergatis Lite notation in documentation

### Workflow Execution
→ Use CWL for running pipelines

### Regulatory Submission
→ Use BCO for FDA compliance

### Publication
→ Include all three formats for completeness

### Long-term Preservation
→ BCO as primary format, CWL for reproducibility, Ergatis Lite for human readability

## Implementation Plan

1. **Phase 1:** Extract Ergatis Lite notation for all 362 components
2. **Phase 2:** Generate CWL for 10-20 representative components
3. **Phase 3:** Create BCO templates for common component types
4. **Phase 4:** Full BCO generation for complete workflows
5. **Phase 5:** Validation and testing

## Benefits of Multi-Format Approach

- **Ergatis Lite:** Preserves original design philosophy (minimal, mathematical)
- **CWL:** Enables modern workflow execution
- **BCO:** Ensures regulatory compliance and long-term preservation
- **Together:** Complete knowledge transfer from Ergatis to modern ecosystem

## References

- Ergatis Lite: `docs/ERGATIS_LITE_SPEC.md`
- CWL: https://www.commonwl.org/
- BCO: https://docs.biocomputeobject.org/
- IEEE 2791-2020: BioCompute Object Standard
