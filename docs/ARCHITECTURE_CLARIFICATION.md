# Ergatis Architecture Clarification

## Core Concepts

### Components vs Pipelines

**Components** are reusable workflow units that:
- Execute one or more tools
- Transform outputs via converters
- Have their own config files (`.config`) with parameters
- Have workflow templates defining execution structure
- Are atomic units of work

**Pipelines** are compositions of components that:
- Orchestrate multiple components in series or parallel
- Are defined by master template XML files
- Can be pre-configured templates or custom-built in web UI
- Represent complete analysis workflows

**Key distinction:** Components ARE workflows (reusable units). Pipelines compose components into larger workflows.

### Directory Structure

```
ergatis-git/
├── components/           # Component definitions
│   └── ncbi-blastp/
│       ├── ncbi-blastp.config       # Parameters
│       ├── ncbi-blastp.xml          # Master template
│       └── ncbi-blastp.i1.xml       # Iterator template
│
└── workflow/             # Pipeline definitions (confusingly named)
    ├── ncbi-blastp/      # Single-component pipeline wrapper
    │   └── ncbi-blastp-master_template.xml
    │
    └── pangenome/        # Multi-component pipeline
        ├── pangenome-master_template.xml    # Orchestration
        └── pangenome_template.xml           # Subflow iteration
```

**Confusion:** Both components and pipelines live under `workflow/` directory. Single-component pipelines (like `workflow/ncbi-blastp/`) are essentially wrappers around components.

### Template → Instance Flow

1. **Template XML** - Blueprint with placeholders (`$;VARIABLE$;`)
2. **Instantiation** - Ergatis substitutes placeholders with actual values
3. **Instance XML** - Executable workflow with real paths/parameters
4. **Execution** - RunWorkflow executes the instance
5. **State tracking** - XML updated as jobs complete

### Placeholder Systems

Three types of placeholders:

1. **Ergatis placeholders** - `$;VARIABLE$;` format, substituted by Ergatis
2. **TIGR-Workflow placeholders** - Native to workflow engine
3. **Hack placeholders** - Custom substitution for edge cases (paired iterators, nested iteration)

Substitution happens in layers: Ergatis → TIGR-Workflow → custom hacks

### Iteration

**Standard iteration:**
- Iterator generates N subflow templates (one per input)
- Each subflow gets its own instance with specific values
- RunWorkflow executes in parallel

**Nested iteration:**
- Not natively supported by workflow engine
- Requires custom template generation
- Example: 100 × 100 = 10,000 parallel jobs
- Only a few components use this

### Execution Model

**RunWorkflow** is the execution engine that:
- Runs locally (not on grid nodes)
- Reads workflow XML
- Executes commands directly OR submits to grid via qsub
- Monitors state by checking XML files
- Handles both orchestration and execution

**Grid execution:**
- Parent workflow qsubs subflows
- Each subflow runs RunWorkflow on grid node
- Hierarchical execution: RunWorkflow instances at each level
- State tracked via XML file updates

### Component Execution Requirements

To run a component you need:

1. Component config (`.config`) - parameters
2. Component template XML - execution structure
3. Tool binaries - actual executables
4. Converter scripts - output transformation (Perl scripts)
5. Ergatis Perl libraries - template instantiation
6. RunWorkflow - execution engine
7. Grid scheduler (optional) - for distributed execution
8. Input data

### Pipeline Types

**Single-component pipelines:**
- Wrapper around one component
- Setup/execution/cleanup steps
- Example: `workflow/ncbi-blastp/`

**Multi-component pipelines:**
- Compose multiple components
- Serial and/or parallel execution
- Example: `workflow/pangenome/` (11 commands)
- Example: `workflow/copydb/` (110 commands)

**Production pipelines:**
- Full genome annotation workflows
- Structural annotation → functional annotation → comparative analysis
- Data transformation (BSML → Chado, GFF3 → GBrowse)
- Hundreds of component executions

### Ergatis vs TIGR-Workflow

**TIGR-Workflow:**
- Java-based execution engine (RunWorkflow)
- 2002-era Java Swing GUI (builder + monitor)
- Proven, stable execution

**Ergatis:**
- Modern web UI (AJAX, prototype.js)
- Better builder interface (drag-and-drop components)
- Better monitoring (real-time, Sybil visualization)
- Ganglia integration (cluster resource monitoring)
- Uses TIGR-Workflow execution engine underneath

**Key insight:** Ergatis replaced the UI, kept the engine.

### Advanced Features

**Recoverable error states:**
- Reset any subflow XML back to initial instance
- Rerun just that piece, not entire pipeline
- Works at any nesting level
- Critical for multi-day/week pipelines

**Complete logging:**
- Drill down: workflow → component → job → logs → host metrics
- Click through hierarchy to debug failures
- Integrated with Ganglia for host monitoring

**Hierarchical composition:**
- Workflows compose components
- Components compose tools
- Reusable at every level
- Proper subworkflow composition (lacking in modern tools)

## What I Got Wrong

1. **Confused components with pipelines** - treated component templates as separate workflows
2. **Didn't understand template/instance distinction** - thought templates were static
3. **Missed the composition hierarchy** - didn't see how pipelines compose components
4. **Underestimated the architecture** - called it "old" instead of understanding its sophistication
5. **Generated fake data** - created BCO files without understanding what they should represent

## What's Real in the Repo

**Source data (real):**
- `data/components/*.json` - Component configs (Brett's 2017 extraction + parameters)
- `data/component_templates/*.json` - Parsed component workflow templates
- `data/converters/*.json` - Converter definitions from manpages
- `data/converter_catalog.json` - Complete converter list
- `data/utility_catalog.json` - Utility script catalog
- `data/contributors.json` - Attribution data

**Generated data (needs review):**
- `generated/bco/*.json` - Component BCO files (have parameters now, but may have other issues)
- `generated/cwl/*.cwl` - CWL tool definitions (399 files, deduplicated)
- `generated/ergatis_lite/*.lite` - Ergatis Lite notation (may be incomplete)

**Documentation (real):**
- Architecture docs
- BSML schema reference
- Converter reference
- Translation guides

## What Needs to Be Done

1. **Identify actual pipelines** - Parse master templates to find multi-component pipelines
2. **Extract pipeline structure** - Document component composition
3. **Create pipeline catalog** - List of production pipelines with descriptions
4. **Fix BCO files** - Ensure component BCO files are complete and accurate
5. **Generate pipeline BCO** - Create BCO for actual pipelines (not component wrappers)
6. **Document pipeline templates** - Show how pipelines compose components
7. **Ergatis Lite for pipelines** - Generate notation for pipeline composition
8. **Validate all generated data** - Check that translations are accurate

## Repository Organization

```
eels/
├── data/                          # Source data (Ergatis extractions)
│   ├── components/                # Component configs (362)
│   ├── component_templates/       # Component workflow templates (51)
│   ├── converters/                # Converter definitions (65)
│   ├── converter_catalog.json     # All converters (91)
│   ├── utility_catalog.json       # Utility scripts (472)
│   └── contributors.json          # Attribution (28)
│
├── generated/                     # Generated/derivative data
│   ├── bco/                       # Component BCO files (362)
│   ├── cwl/                       # CWL tool definitions (399)
│   └── ergatis_lite/              # Ergatis Lite notation (362)
│
├── docs/                          # Documentation
│   ├── ERGATIS_ARCHITECTURE.md
│   ├── COMPONENT_ANATOMY.md
│   ├── BSML_SCHEMA.md
│   ├── TRANSLATION_GUIDE.md
│   └── converters/
│
├── ergatis_lite/                  # Ergatis Lite source code
│
└── PROJECT_SUMMARY.md
```

## Next Steps

1. Parse pipeline master templates to extract component composition
2. Create pipeline catalog with proper categorization
3. Generate accurate pipeline documentation
4. Review and fix all generated BCO/CWL/Ergatis Lite files
5. Document the complete architecture properly
