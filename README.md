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

This is production-tested software representing institutional knowledge from TIGR/JCVI/IGS genomics annotation pipelines.

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

### In Progress

Work is ongoing. See `docs/ARCHITECTURE_CLARIFICATION.md` for current understanding.

## Repository Structure

```
eels/
├── data/                        # Source data (Ergatis extractions)
│   ├── components/              # 362 component configs (Brett, 2017)
│   ├── component_templates/     # Component workflow templates (parsed XML)
│   ├── converters/              # 65 converter definitions (from manpages)
│   ├── converter_catalog.json   # All converters (91)
│   ├── utility_catalog.json     # Utility scripts (472)
│   ├── iterator_catalog.json    # Iterator patterns
│   ├── workflow_catalog.json    # Workflow catalog
│   └── contributors.json       # Attribution (28)
│
├── generated/                   # Generated/derivative data
│   ├── bco/                     # Component BCO files (362)
│   ├── cwl/                     # CWL tool definitions (399)
│   └── ergatis_lite/            # Ergatis Lite notation (362)
│
├── ergatis_lite/                # Ergatis Lite source code (Brett, 2007)
│
├── docs/                        # Documentation
│   ├── ARCHITECTURE_CLARIFICATION.md
│   ├── ERGATIS_ARCHITECTURE.md
│   ├── COMPONENT_ANATOMY.md
│   ├── BSML_SCHEMA.md
│   ├── ERGATIS_LITE_SPEC.md
│   ├── CONVERTER_REFERENCE.md
│   ├── TRANSLATION_GUIDE.md
│   ├── TRANSLATION_STRATEGY.md
│   └── BCO_MAPPING.md
│
├── CONTRIBUTORS.md
├── PHILOSOPHY.md
└── README.md
```

## Source Material

- **Ergatis source:** `ergatis-eels-devel/ergatis-git/`
- **Components:** `components/` (configs) + `workflow/` (templates)
- **Scripts:** Perl scripts in `src/perl/` (converters + utilities)
- **Ergatis Lite:** Brett Whitty, JCVI, 2007

## Project Context

**Lead:** Brett Whitty (GNOMATIX), original TIGR developer  
**Started:** 2026-02-18
