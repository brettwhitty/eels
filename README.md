# EELS - Ergatis Extended Lifetime Support

Systematic extraction and preservation of institutional knowledge from the Ergatis bioinformatics workflow system (TIGR/JCVI/IGS, 2003-present).

!["EELS!"](assets/images/eels-banner-m.png "EELS!")

## Objective

Extract and preserve 20+ years of production genomics annotation knowledge encoded in Ergatis components, converters, and workflows. Document in structured formats: Component JSON, Ergatis Lite notation, CWL (tool configs), and BioCompute Object (IEEE standard).

## What is Ergatis?

Ergatis is a web-based utility for creating, running, and monitoring reusable computational analysis pipelines. It contains pre-built components for common bioinformatics analysis tasks that can be arranged graphically to form highly-configurable pipelines.

- Orvis J, et al. *Bioinformatics*. 2010 Jun 15;26(12). https://ergatis.sourceforge.net/

## What is EELS preserving?

The components, converters, and pipeline templates that were developed by contributors at TIGR, JCVI, and IGS over many years of production genome annotation work. This knowledge is encoded in configuration files, workflow templates, and Perl scripts - not in the Ergatis platform itself. Many of the people who built these components are not on the Ergatis paper.

See `CONTRIBUTORS.md` for attribution.

![]()<img src='https://outrage.dataglut.org/assets/badges/ioa-safe-badge-provisional.svg' width='250px'>

## Progress

### Completed (Phases 1-3)

**Data Extraction:**
- 362 components analyzed → `data/components/*.json`
- 254 iterator patterns cataloged → `data/iterator_catalog.json`
- 40 pipeline templates extracted → `data/pipelines/*.json`
- 51 component templates extracted → `data/component_templates/*.json`
- 472 utility scripts cataloged → `data/utility_catalog.json`
- 91 converters identified → `data/converter_catalog.json`
- 65 converter configs → `data/converters/*.json`
- 28 contributors identified → `data/contributors.json`

**Translation Formats Generated:**
- 362 Ergatis Lite component notations → `generated/ergatis_lite/*.lite`
- 362 BioCompute Objects → `generated/bco/*.json`
- 399 CWL tool definitions → `generated/cwl/*.cwl`

**Note:** Converter manpages exist in `ergatis-install/man/man1/*2bsml.pl.1p` (65 files)

**Documentation:**
- Component anatomy walkthrough → `docs/COMPONENT_ANATOMY.md`
- Converter reference guide → `docs/CONVERTER_REFERENCE.md`
- Ergatis Lite specification → `docs/ERGATIS_LITE_SPEC.md`
- Contributor attribution → `CONTRIBUTORS.md`

### In Progress

Work is ongoing. See `docs/ARCHITECTURE_CLARIFICATION.md` for current understanding.

## Repository Structure

```
eels/
├── data/                        # Source data (Ergatis extractions)
│   ├── components/              # 362 component configs (Brett, 2017)
│   ├── component_templates/     # 51 component workflow templates (parsed XML)
│   ├── component_docs/          # 75 HTML documentation templates
│   ├── converters/              # 65 converter definitions (from manpages)
│   ├── pipelines/               # 40 production pipeline templates
│   ├── reference/               # DTD, XSD, iterator templates, project config
│   ├── pipeline_catalog.json    # Pipeline summary
│   ├── converter_catalog.json   # All converters (91)
│   ├── utility_catalog.json     # Utility scripts (472)
│   ├── iterator_catalog.json    # Iterator patterns
│   └── contributors.json       # Attribution
│
├── generated/                   # Generated/derivative data
│   ├── bco/                     # Component BCO files (362)
│   ├── cwl/                     # CWL tool definitions (399)
│   └── ergatis_lite/            # Ergatis Lite notation (362)
│
├── tools/                       # EELS Perl scripts (Brett's extraction tools)
│   ├── workflow_xml_to_json.pl  # Core XML to JSON converter
│   ├── to_json.pl               # Batch component XML converter
│   ├── simple_to_nextflow.pl    # JSON to Nextflow converter
│   └── parse_pipeline_layout.pl # Pipeline layout parser
│
├── ergatis_lite/                # Ergatis Lite source code (Brett, 2007)
│
├── docs/                        # Documentation
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

!["GNOMATIX"](assets/images/gnomatix-new-xs.png)
