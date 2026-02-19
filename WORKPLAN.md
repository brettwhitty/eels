# EELLMS Work Plan

**Project:** EELS - Ergatis Extended Lifetime Support
**Date:** 2026-02-18
**Lead:** Brett Whitty <brett@gnomatix.com> (GNOMATIX)

## Objective

Extract institutional knowledge from Ergatis bioinformatics workflow system and translate to modern workflow formats (CWL/Nextflow/WDL).

## Completed (Phase 1)

✅ **BSML Converter Catalog** - Extracted metadata from 67 `*2bsml.pl` converter scripts  
✅ **Repository Analysis** - Documented structure of source and install directories  
✅ **Architecture Documentation** - Analyzed workflow XML hierarchy from `doc/workflowxml.txt`  
✅ **Contributor Extraction** - Identified 28 contributors from source code  
✅ **CONTRIBUTORS.md** - Created attribution document recognizing all authors  
✅ **Component Anatomy** - Complete walkthrough of `wait` component structure

## Phase 2: Component Analysis

### 2.1 Sample Component Trace
**Goal:** Understand the full config → template → runtime XML chain

**Tasks:**
- [ ] Select simple component (`wait`, `split_multifasta`, or similar)
- [ ] Parse component `.config` file (INI format)
- [ ] Parse component template XML (`.xml` file from `components/`)
- [ ] Identify iterator templates (`.i1.xml`, `.i2.xml` if present)
- [ ] Trace placeholder variable expansion (`$;KEY$;` → actual values)
- [ ] Document the instantiation process

**Output:** `docs/COMPONENT_ANATOMY.md` - detailed walkthrough of one component

### 2.2 Iterator Pattern Extraction
**Goal:** Identify parallelization strategies across all components

**Tasks:**
- [ ] Scan all 371 component directories for iterator templates
- [ ] Classify iterator types:
  - Simple (single input list)
  - Paired (two synchronized lists)
  - Combinatorial (all-vs-all)
  - Nested (iterator within iterator)
  - Tiling (coordinate-based with remapping)
- [ ] Extract `GROUP_COUNT` and batching logic
- [ ] Document scatter/gather patterns

**Output:** `data/iterator_patterns.json` + `docs/ITERATOR_PATTERNS.md`

### 2.3 Component Catalog
**Goal:** Build comprehensive component inventory

**Tasks:**
- [ ] Extract metadata from all 371 components:
  - Component name and purpose
  - Input/output file types
  - Iterator configuration
  - Dependencies (which converters used)
  - Configuration parameters
- [ ] Link components to converters (which `*2bsml.pl` scripts are called)
- [ ] Identify component dependencies (which components call others)

**Output:** `data/component_catalog.json` + `docs/COMPONENT_CATALOG.md`

## Phase 3: Deep Converter Analysis

### 3.1 BLAST Converter Deep Dive
**Goal:** Extract full parsing logic and BSML mapping from `blast2bsml.pl`

**Tasks:**
- [ ] Extract BLAST output parsing logic
- [ ] Document BSML XML structure generated
- [ ] Identify semantic mappings (BLAST fields → BSML elements)
- [ ] Extract parameter handling
- [ ] Document coordinate systems and transformations

**Output:** `docs/converters/blast2bsml_analysis.md`

### 3.2 Priority Converter Analysis
**Goal:** Deep analysis of 5-10 key converters

**Priority List:**
1. `blast2bsml.pl` - Fundamental alignment tool
2. `glimmer32bsml.pl` - Gene prediction
3. `hmmpfam2bsml.pl` / `hmmpfam32bsml.pl` - Protein domains
4. `aragorn2bsml.pl` - tRNA/tmRNA prediction
5. `augustus2bsml.pl` - Eukaryotic gene prediction
6. `prodigal2bsml.pl` - Prokaryotic gene prediction

**Output:** `docs/converters/{tool}_analysis.md` for each

## Phase 4: Pipeline Analysis

### 4.1 Skeleton XML Extraction
**Goal:** Identify saved pipeline templates

**Tasks:**
- [ ] Scan for skeleton XML files in `workflow/savedpipelines/`
- [ ] Parse component ordering
- [ ] Extract configuration references
- [ ] Identify common pipeline patterns

**Output:** `data/pipeline_catalog.json`

### 4.2 Pipeline Composition Patterns
**Goal:** Understand how components are composed into pipelines

**Tasks:**
- [ ] Analyze component ordering constraints
- [ ] Identify data flow patterns (output of A → input of B)
- [ ] Document common pipeline motifs (annotation, assembly, etc.)
- [ ] Extract parallelization strategies at pipeline level

**Output:** `docs/PIPELINE_PATTERNS.md`

## Phase 5: BSML Schema Documentation

### 5.1 BSML Structure Analysis
**Goal:** Document the BSML XML schema used for data exchange

**Tasks:**
- [ ] Extract BSML DTD/schema from `lib/BSML/`
- [ ] Document core elements (Sequence, Feature, Alignment, etc.)
- [ ] Identify semantic conventions (how tools use BSML)
- [ ] Map BSML to modern formats (GFF3, JSON, etc.)

**Output:** `docs/BSML_SCHEMA.md`

### 5.2 Chado Integration
**Goal:** Understand BSML → Chado database loading

**Tasks:**
- [ ] Analyze `bsml2chado` component
- [ ] Document database schema mapping
- [ ] Identify data transformations during load

**Output:** `docs/CHADO_INTEGRATION.md`

## Phase 6: Modern Translation

### 6.1 Primitive Mapping
**Goal:** Map Ergatis concepts to modern workflow primitives

**Tasks:**
- [ ] Component → CWL CommandLineTool / Nextflow process / WDL task
- [ ] Iterator → CWL scatter / Nextflow each / WDL scatter
- [ ] Pipeline → CWL Workflow / Nextflow workflow / WDL workflow
- [ ] File-based subflows → workflow composition patterns
- [ ] Variable expansion → workflow parameter passing
- [ ] Evaluate **Ergatis lite S-expression format** as native representation
  - Minimal syntax designed for command-line one-liners
  - `()` = serial, `{}` = parallel, `<>` = component
  - Built by a workflow expert for workflow experts
  - See `/home/brett/work.local/ergatis-eels-devel/ergatis_lite/`

**Output:** `docs/TRANSLATION_GUIDE.md`

### 6.2 Proof-of-Concept Translations
**Goal:** Translate 2-3 simple components to each target format

**Tasks:**
- [ ] Select simple components (wait, split_multifasta, blast)
- [ ] Translate to CWL
- [ ] Translate to Nextflow
- [ ] Translate to WDL
- [ ] Validate translations execute correctly

**Output:** `examples/{cwl,nextflow,wdl}/` with working examples

### 6.3 Translation Tooling
**Goal:** Build automated translation tools

**Tasks:**
- [ ] Improve `simple_to_nextflow.pl` to handle iterators
- [ ] Build CWL translator
- [ ] Build WDL translator
- [ ] Create validation framework

**Output:** `scripts/translate_{cwl,nextflow,wdl}.py`

## Phase 7: Documentation & Preservation

### 7.1 Knowledge Base
**Goal:** Comprehensive documentation for future maintainers

**Tasks:**
- [ ] Architecture overview
- [ ] Component reference guide
- [ ] Converter reference guide
- [ ] Translation cookbook
- [ ] Historical context (TIGR era, design decisions)
- [ ] Contributor biographies (recognize the human expertise)

**Output:** Complete documentation in `docs/`

### 7.2 Contributor Recognition
**Goal:** Document the people behind the code

**Tasks:**
- [ ] Research contributor backgrounds and publications
- [ ] Document their contributions to bioinformatics field
- [ ] Create biographical sketches for key contributors
- [ ] Recognize the PhD-level curators who provided feedback
- [ ] Document the collaborative process (engineers + biologists)

**Output:** `docs/CONTRIBUTOR_BIOS.md` - detailed profiles

**Note:** These individuals made significant contributions to the field. The "grunt work" of building production annotation systems, developing data standards (BSML, Chado integration), and engineering robust parallelization strategies deserves recognition. This was serious engineering work done by serious professionals.

### 7.2 Archive Package
**Goal:** Preserve extracted knowledge in portable format

**Tasks:**
- [ ] Package all catalogs, analyses, and documentation
- [ ] Include original Ergatis source for reference
- [ ] Create browsable HTML documentation
- [ ] Archive to long-term storage

**Output:** `eellms-archive-{version}.tar.gz`

## Immediate Next Steps (This Week)

1. **Component Trace** - Pick `wait` component, trace full instantiation
2. **Iterator Scan** - Quick scan of all components for iterator patterns
3. **BLAST Deep Dive** - Start extracting parsing logic from `blast2bsml.pl`

## Success Criteria

- [ ] All 67 converters analyzed and documented
- [ ] All 371 components cataloged with metadata
- [ ] Iterator patterns classified and documented
- [ ] BSML schema fully documented
- [ ] 10+ components successfully translated to modern formats
- [ ] Translation guide enables future conversions
- [ ] Knowledge preserved for 20+ year horizon

## Resources

**Source:** `/home/brett/work.local/ergatis-eels-devel/ergatis-git/`
**Working:** `/home/brett/work.local/ergatis-eels-devel/eellms/`
**Install:** `/home/brett/work.local/ergatis-eels-devel/ergatis-install/`

**Key Files:**
- `doc/workflowxml.txt` - Architecture overview
- `src/perl/*2bsml.pl` - 67 converter scripts
- `components/` - 371 component directories
- `lib/BSML/` - BSML library modules
- `lib/Ergatis/` - Ergatis core modules

## Notes

- Focus on **pre-2008 components** - these have the best documentation (TIGR era)
- Priority is **knowledge extraction**, not running code
- Write **minimal code** - only what's needed for extraction
- User (Brett) is the domain expert - leverage his knowledge
- This is **institutional memory preservation** for bioinformatics community
- **Ergatis lite S-expression format** (2007) may be a better native representation than XML
  - Minimal syntax designed for command-line one-liners
  - More human-readable than XML, more structured than YAML
  - Consider as primary format for extracted knowledge
