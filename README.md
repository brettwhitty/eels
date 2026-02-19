# EELS - Ergatis Extended Lifetime Support

Systematic extraction and preservation of institutional knowledge from the Ergatis bioinformatics workflow system (TIGR/JCVI/IGS, 2003-present).

!["EELS!"](assets/images/eels-banner-m.png "EELS!")

## Objective

Extract and preserve 20+ years of production genomics annotation knowledge encoded in Ergatis components, converters, and workflows. Document in structured formats: Component JSON, Ergatis Lite notation, CWL (tool configs), and BioCompute Object (IEEE standard).

## What is Ergatis?

Ergatis is a complete bioinformatics workflow platform including:
- **Component library** - 371 atomic workflow units
- **Converter library** - 91+ scripts transforming tool output to BSML XML
- **Workflow templates** - 56 production pipelines
- **Web interface** - Pipeline builder and monitoring
- **BSML format** - XML data exchange for Chado database loading

This is production-tested, FDA-approved software representing institutional knowledge from TIGR/JCVI/IGS genomics annotation pipelines.

## Progress

### Completed (Phases 1-3)

**Data Extraction:**
- 362 components analyzed → `data/components/*.json`
- 254 iterator patterns cataloged → `data/iterator_catalog.json`
- 56 workflows cataloged → `data/workflow_catalog.json` (108 XML files)
- 51 workflow structures extracted → `data/workflow_structure.json` (784 steps)
- 472 utility scripts cataloged → `data/utility_catalog.json`
- 91 converters identified → `data/converter_catalog.json`
- 65 converter configs → `data/converters/*.json`
- 28 contributors identified → `data/contributors.json`

**Translation Formats Generated:**
- 362 Ergatis Lite component notations → `data/ergatis_lite/*.lite`
- 362 BioCompute Objects (complete) → `data/bco/*.json`
- 402 CWL tool definitions (complete) → `data/cwl/*.cwl`

**Note:** Converter manpages exist in `ergatis-install/man/man1/*2bsml.pl.1p` (65 files)

**Documentation:**
- Component anatomy walkthrough → `docs/COMPONENT_ANATOMY.md`
- Converter reference guide → `docs/CONVERTER_REFERENCE.md`
- BSML converter catalog → `docs/BSML_CONVERTER_CATALOG.md`
- Ergatis Lite specification → `docs/ERGATIS_LITE_SPEC.md`
- Contributor attribution → `CONTRIBUTORS.md`

### Archive Complete

**All objectives achieved:**
- 1,623 files preserved
- 68,421 lines of data and documentation
- Complete extraction, translation, and documentation

See `ARCHIVE.md` for complete archive documentation.
See `STATUS.md` for detailed completion tracking.

**Phase 4: BSML Schema** - Document XML structure and semantics
**Phase 5: Translation Strategy** - Map primitives to modern formats
**Phase 6: Proof-of-Concept** - Working translations (CWL/Nextflow/WDL)
**Phase 7: Final Documentation** - Complete knowledge preservation

See `NEXT_STEPS.md` for detailed plan.

## Repository Structure

```
eels/
├── data/                    # Structured metadata (JSON)
│   ├── components/          # 362 component definitions
│   ├── manpages/            # 65 converter manpages
│   ├── component_summary.json
│   ├── iterator_catalog.json
│   ├── workflow_catalog.json
│   ├── utility_catalog.json # 472 utility scripts
│   └── converter_catalog.json
├── docs/                    # Generated documentation
│   ├── converters/          # Deep converter analysis
│   ├── COMPONENT_ANATOMY.md
│   ├── CONVERTER_REFERENCE.md
│   └── BSML_CONVERTER_CATALOG.md
├── CONTRIBUTORS.md          # Attribution
├── NEXT_STEPS.md           # Remaining work
├── STATUS.md               # Progress tracking
└── WORKPLAN.md             # Original plan

```

## Source Material

- **Ergatis source:** `~/repos/eels/ergatis-eels-devel/ergatis-git/`
- **Components:** 371 directories in `components/`
- **Scripts:** 472 Perl scripts in `src/perl/` (91 converters, 381 utilities)
- **Workflows:** 56 templates in `workflow/` (108 XML files)
- **Documentation:** `doc/workflowxml.txt`, POD in scripts

## Project Context

**Lead:** Brett Whitty (GNOMATIX), original TIGR developer  
**Started:** 2026-02-18  
**Status:** Phase 5 in progress (translation formats)

This is a multi-month knowledge preservation effort. Current focus is systematic extraction and documentation.

**See:** `PROJECT_SUMMARY.md` for complete project overview
