# EELS Project Status

## 2026-02-18 - Phase 2 Complete

### Phase 1: Initial Extraction (Complete)

✅ BSML Converter Catalog - 67 converters documented
✅ Repository Analysis - Structure documented
✅ Architecture Documentation - 6-level XML hierarchy
✅ Contributor Extraction - 28 contributors identified
✅ CONTRIBUTORS.md - Attribution document created
✅ Component Anatomy - Complete `wait` component walkthrough

### Phase 2: Structured Analysis (Complete)

✅ **Component Execution Analysis** - 362 components analyzed
  - Individual JSON per component in `data/components/`
  - Summary in `data/component_summary.json`
  - Tool execution chains extracted
  - Converter usage identified
  - 91 unique converters found

✅ **Iterator Pattern Catalog** - 254 components with iterators
  - Catalog in `data/iterator_catalog.json`
  - Iterator types documented (serial/parallel)
  - Command counts extracted
  - Nested commandSet detection

✅ **Component Catalog Summary** - Complete inventory
  - 362 total components
  - 253 with iterators
  - Classifications extracted
  - Output formats documented

### Data Model Created

All component data now in structured JSON format:
- `data/components/*.json` - Individual component metadata
- `data/component_summary.json` - Aggregate statistics
- `data/iterator_catalog.json` - Iterator patterns
- `data/component_catalog_summary.json` - Complete inventory
- `data/converter_catalog.json` - BSML converter metadata
- `data/contributors.json` - Contributor information

### Next Steps (Phase 3)

**Deep Converter Analysis:**
1. Extract parsing logic from `blast2bsml.pl` (40K file)
2. Document BSML XML structure generated
3. Identify semantic mappings (BLAST → BSML)
4. Analyze 5-10 priority converters

**Priority Converters:**
- blast2bsml.pl - Alignment tool (fundamental)
- glimmer32bsml.pl - Gene prediction
- hmmpfam2bsml.pl - Protein domains
- aragorn2bsml.pl - tRNA prediction
- augustus2bsml.pl - Eukaryotic genes
- prodigal2bsml.pl - Prokaryotic genes

### Repository Structure

```
eellms/
├── README.md
├── STATUS.md (this file)
├── scripts/
│   ├── extract_converter_metadata.py
│   └── generate_summary.py
├── data/
│   └── converter_catalog.json
└── docs/
    └── CONVERTER_CATALOG.md
```

### Resources

- Source: `/home/brett/work.local/ergatis-eels-devel/ergatis-git/src/perl/`
- 67 converters documented
- ~1700 lines of generated documentation

## Ergatis Repository Structure

### Source Repository (`ergatis-git/`)

**Key Directories:**
- `src/perl/` - **67 BSML converter scripts** (`*2bsml.pl`) - domain knowledge extraction target
- `components/` - **371 component directories** - atomic workflow units
- `workflow/` - **59 workflow directories** - workflow templates and runtime XML
- `lib/` - **25 Perl module directories** - shared libraries (Ergatis::*, BSML::*, Workflow::*)
- `doc/` - Documentation including `workflowxml.txt` (architecture overview)
- `templates/` - Component templates
- `samples/` - Example configurations
- `util/` - Utility scripts
- `web/` - Web interface code
- `htdocs/` - Static web assets

**Key Files:**
- `Makefile.PL` - Perl build system
- `INSTALL` - Installation instructions
- `LICENSE` - Software license
- `MANIFEST` - File listing for distribution

### Install Directory (`ergatis-install/`)

**Deployed Structure:**
- `docs/` - **Component configs** (`.config`, `.i1.json`, `.i2.json` files)
  - ~7400+ files including component templates and JSON conversions
  - Contains `simple_to_nextflow.pl` - incomplete Nextflow translator
- `bin/` - Installed executable scripts
- `lib/` - Installed Perl modules
- `templates/` - Runtime templates
- `samples/` - Sample configurations
- `software.config` / `project.config` - Global configuration files

### Workflow XML Hierarchy (from `doc/workflowxml.txt`)

Ergatis uses a 6-level XML hierarchy for workflow execution:

1. **Skeleton XML** - GUI-generated pipeline template (reusable)
2. **Pipeline XML** - Instantiated pipeline with unique PIPELINE_ID
3. **Component XML** - Top-level component execution steps
4. **Iterator XML** - Parallel batch/group distribution
5. **Group XML** - Serial execution within a batch
6. **Element XML** - Single input file processing

**Key Concepts:**
- **File-based subflows** - XML files reference other XML files
- **Iterator variables** - `$;KEY$;` placeholders replaced at runtime
- **GROUP_COUNT** - User-defined parallelization factor
- **create_iterator_groups** - Script that batches input sets
- **replace_config_keys** - Expands INI placeholders
- **replace_template_keys** - Expands XML placeholders

### Translation Strategy

**Priority 1: Converters** (domain knowledge)
- Extract parsing logic from `*2bsml.pl` scripts
- Understand tool output formats
- Document semantic mappings to BSML

**Priority 2: Components** (workflow units)
- Parse component `.config` files
- Extract iterator patterns (`.i1.xml`, `.i2.xml`)
- Identify input/output dependencies

**Priority 3: Pipelines** (workflow composition)
- Parse skeleton XML files
- Extract component ordering
- Identify data flow patterns

**Priority 4: Modern Translation**
- Map Ergatis primitives to CWL/Nextflow/WDL
- Translate iterator patterns to scatter/gather
- Preserve parallelization strategies

### Ergatis lite Format (2007)

Brett's **Ergatis lite** project (the "lite" is lowercase - it's the Diet version) introduced a bracket-based format designed for command-line one-liners.

**Mathematical Foundation:**
- `()` = **Ordered list** (serial execution - order matters)
- `{}` = **Unordered set** (parallel execution - order doesn't matter)
- `<component:key=val>` = Component with configuration

**Design Basis:**
- Perl Data::Dumper syntax (familiar to Perl developers)
- Mathematical ordered/unordered list notation
- Minimal syntax for workflow experts

**Example:**
```
(
    <split_fasta>,
    {<blast.db1:database=/path/to/db1>, <blast.db2:database=/path/to/db2>},
    <merge_results>
)
```

**Consideration:** This format may be superior to XML/YAML for representing extracted knowledge and could serve as the native format for the EELS catalog.

**Specification:** See `docs/ERGATIS_LITE_SPEC.md`  
**Location:** `/home/brett/work.local/ergatis-eels-devel/ergatis_lite/`
