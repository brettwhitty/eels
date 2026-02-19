# EELLMS Project Status

## 2026-02-18 - Initial Extraction

### Completed

✅ Created `eellms` directory structure
✅ Built converter metadata extraction script
✅ Extracted metadata from 67 `*2bsml.pl` converter scripts
✅ Generated structured JSON catalog (`data/converter_catalog.json`)
✅ Created markdown summary (`docs/CONVERTER_CATALOG.md`)

### Findings

- **67 BSML converters** identified and documented
- Each converter contains:
  - Tool name and purpose
  - Input/output formats
  - Command-line parameters
  - Author/contact information (mostly Brett Whitty, pre-2008 TIGR era)
  - Usage examples

### Key Converters Identified

High-value tools for initial deep analysis:
- `blast2bsml.pl` - BLAST output parsing (fundamental)
- `glimmer32bsml.pl` - Gene prediction
- `hmmpfam2bsml.pl` / `hmmpfam32bsml.pl` - Protein domain search
- `aragorn2bsml.pl` - tRNA/tmRNA prediction
- `augustus2bsml.pl` - Eukaryotic gene prediction
- `prodigal2bsml.pl` - Prokaryotic gene prediction

### Next Steps

1. **Deep analysis of BLAST converter** - Extract full parsing logic, understand BSML output structure
2. **Component config extraction** - Parse the `.config` and `.xml` files for each component
3. **Iterator pattern analysis** - Identify parallelization strategies from component templates
4. **BSML schema documentation** - Understand the output data model
5. **Build component catalog** - Link converters → components → pipelines

### Technical Debt

- Need to handle gzipped files in extraction
- Some converters have embedded Perl code in POD (need better parsing)
- Contact info parsing could be improved
- Should extract version information where available

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
