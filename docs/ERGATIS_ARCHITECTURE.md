# Ergatis Architecture: Hierarchical Workflow Composition

## Core Concepts

**TIGR-Workflow** is a workflow engine that uses XML to encode computational workflows with serial or parallel, distributed or local, execution steps.

**Ergatis** provides libraries, templates, and a web UI on top of TIGR-Workflow. It introduces the concept of reusable **components** — templates that define analysis steps — which are composed into executable **pipeline workflows**.

### Three-Level Hierarchy

```
Pipeline Workflow (executable by TIGR-Workflow)
  ├─ Component (template, instantiated into pipeline)
  │   ├─ Tool execution
  │   ├─ Tool execution
  │   └─ Converter
  ├─ Component (template, instantiated into pipeline)
  │   ├─ Tool execution
  │   └─ Converter
  └─ Component (template, instantiated into pipeline)
      └─ Tool execution
```

### Level 1: Tool
**Atomic executable** - BLAST, HMMer, Glimmer3, etc.

### Level 2: Component (Template)
**Reusable template** defining a multi-step analysis unit:
- Run tool(s)
- Convert output formats
- Validate results
- Clean up intermediate files

Components are NOT directly executable by TIGR-Workflow. They must be instantiated into a pipeline workflow XML to run.

**Example:** BLAST component
1. Run BLAST (tool)
2. Convert to BTAB (converter)
3. Convert to BSML (converter)
4. Validate BSML (validation)
5. Clean up raw files

### Level 3: Workflow (Pipeline)
**Composition of components** - Complete analysis pipeline
- Order components
- Define data flow between components
- Manage dependencies

**Example:** Prokaryotic Annotation Pipeline
1. Glimmer3 component (gene prediction)
2. BLAST component (protein alignment)
3. HMMpfam component (domain search)
4. tRNAscan component (tRNA genes)
5. Merge component (combine annotations)
6. BSML2Chado component (database load)

## Parallelization in Ergatis

Parallelization happens **within** components via iterators.

**Iterator pattern:**
- Component receives list of 1000 input files
- Creates 150 parallel groups (GROUP_COUNT=150)
- Each group processes ~7 files serially
- Results aggregated after completion

This is batch processing on HPC with persistent infrastructure.

## Ergatis Lite

Mathematical notation for hierarchical composition.

**Workflow:**
```
(
  <glimmer3>,
  {<blast>, <hmmpfam>},  # parallel components
  <merge>
)
```

**Component (subworkflow):**
```
<blast> = (
  <blastp:db=/db/nr>,
  <blast2btab>,
  <blast2bsml>,
  <validate>
)
```

**Hierarchical composition** - workflows compose components, components compose tools

### BioCompute Object
**IEEE standard** - Captures full hierarchy

```json
{
  "pipeline_steps": [
    {
      "step_number": 1,
      "name": "BLAST component",
      "description": "Multi-step BLAST analysis",
      "substeps": [
        {"substep": 1, "name": "Run BLASTP"},
        {"substep": 2, "name": "Convert to BTAB"},
        {"substep": 3, "name": "Convert to BSML"},
        {"substep": 4, "name": "Validate BSML"}
      ]
    }
  ]
}
```

## Production Context

**TIGR/JCVI/IGS infrastructure:**
- SGE/Grid Engine job scheduling
- Shared filesystem (NFS/Lustre)
- Persistent compute nodes
- Database-backed workflow tracking
- 1000s of genomes annotated

## Key Insight

Ergatis components are **reusable subworkflows**, not just "steps in a pipeline."

A component encapsulates:
- Tool execution logic
- Format conversion
- Validation
- Error handling
- Cleanup

This is **software engineering for bioinformatics workflows**.

## Translation Strategy

**Preserve the hierarchy:**
1. Tool configs → CWL CommandLineTool
2. Components → Ergatis Lite notation + BCO substeps
3. Workflows → Ergatis Lite notation + BCO pipeline

**Don't flatten:**
- Don't convert components to flat workflow steps
- Don't lose the subworkflow abstraction

**Preserve the knowledge:**
- Components are reusable units (like functions)
- Workflows compose components (like programs)
- This is compositional software engineering

## References

- `docs/COMPONENT_ANATOMY.md` - Component structure walkthrough
- `docs/ERGATIS_LITE_SPEC.md` - Hierarchical composition notation
- `doc/workflowxml.txt` - Original architecture documentation
- 362 component JSON files - Complete component library
- 40 pipeline templates - Production pipelines

### Academic References

- Yu, J. & Buyya, R. (2005). "A Taxonomy of Workflow Management Systems for Grid Computing." arXiv:cs/0503025
  - Grid workflow taxonomy and classification
  - Context for Ergatis as Grid workflow system
  - https://arxiv.org/abs/cs/0503025

- Singh, G., Kesselman, C. & Deelman, E. (2005). "Optimizing Grid-Based Workflow Execution." Journal of Grid Computing, 3, 201-219.
  - Grid workflow optimization and execution
  - DOI: 10.1007/s10723-005-9011-7

- Chen, J. & Yang, Y. (2009). "Grid and Workflows." In: Encyclopedia of Database Systems. Springer.
  - Grid workflow management systems overview
  - DOI: 10.1007/978-0-387-39940-9_1472
