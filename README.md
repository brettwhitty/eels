# EELS - Ergatis Extended Lifetime Support

Systematic extraction and preservation of institutional knowledge from the Ergatis bioinformatics workflow system (TIGR/JCVI/IGS, 2003-present).

!["EELS!"](assets/images/eels-banner-m.png "EELS!")

## Objective

Extract and preserve 20+ years of production genomics annotation knowledge encoded in Ergatis components, converters, and pipeline templates. Translate to modern structured formats (CWL, Nextflow, BioCompute Object, Ergatis Lite) and map tools to community registries (bio.tools, EDAM ontology).

## What is Ergatis?

Ergatis is a web-based workflow management system for creating, running, and monitoring reusable computational analysis pipelines. Components for common bioinformatics tasks can be arranged graphically to form highly-configurable, parallelized workflows with automatic provenance tracking.

- Orvis J, et al. *Ergatis: a web interface and scalable software system for bioinformatics workflows.* Bioinformatics. 2010 Jun 15;26(12):1488-92. https://ergatis.sourceforge.net/

## What is EELS preserving?

The components, converters, and pipeline templates developed by contributors at TIGR, JCVI, and IGS over many years of production genome annotation work. This knowledge is encoded in XML workflow templates, INI configuration files, and Perl scripts — it represents the accumulated expertise of the people who built and ran these pipelines, not the Ergatis platform itself. Many of the people who built these components are not on the Ergatis paper.

See `CONTRIBUTORS.md` for attribution of the 33 identified contributors.

![]()<img src='https://outrage.dataglut.org/assets/badges/ioa-safe-badge-provisional.svg' width='250px'>

## Current State

**Extracted Data:**
- 362 component configurations → `data/components/`
- 383 categorized workflow steps → `data/categorized_steps/`
- 65 converter configurations → `data/converters/`
- 40 pipeline templates → `data/pipelines/`
- 51 component workflow templates → `data/component_templates/`
- 437 tool executables cataloged → `data/tool_catalog_full.json`
- 37 reference databases cataloged → `data/database_catalog.json`
- 65 converter→component mappings → `data/converter_mapping.json`
- 121 components mapped to bio.tools → `data/biotools_mapping.json`
- 121 components mapped to EDAM ontology → `data/edam_mapping.json`
- JSON Schema for component data → `data/schemas/`

**Generated Translations:**
- 362 CWL tool definitions → `generated/wfl-lang/cwl/components/`
- 383 Nextflow process definitions → `generated/wfl-lang/nextflow/components/`
- 40 Nextflow pipeline workflows → `generated/wfl-lang/nextflow/pipeline_templates/`
- 362 BioCompute Objects → `generated/docs/bco/components/`
- 40 pipeline BioCompute Objects → `generated/docs/bco/pipeline_templates/`
- 362 Ergatis Lite notations → `generated/wfl-lang/ergatis_lite/components/`
- 40 pipeline Ergatis Lite notations → `generated/wfl-lang/ergatis_lite/pipeline_templates/`

**Tools & Viewer:**
- Web-based component viewer → `viewer/`
- Perl extraction and translation tools → `tools/`

**Documentation:**
- [Wiki](https://gitea.gnomatix.com/gnomatix/eels/wiki/) — Iterator system, pipeline architecture, tool catalog, database catalog
- Component anatomy → `docs/COMPONENT_ANATOMY.md`
- Ergatis Lite specification → `docs/ERGATIS_LITE_SPEC.md`
- Contributor attribution → `CONTRIBUTORS.md`

## Repository Structure

```
eels/
├── data/                        # Extracted source data
│   ├── components/              # 362 component configs (JSON, from Brett's 2017 extraction)
│   ├── categorized_steps/       # 383 step-level analysis (tool/converter/infra/validation)
│   ├── component_templates/     # 51 component workflow templates (parsed XML)
│   ├── converters/              # 65 converter definitions
│   ├── pipelines/               # 40 production pipeline templates
│   ├── reference/               # DTD, XSD, software.config, project.config
│   ├── schemas/                 # JSON Schema for component data
│   ├── biotools_mapping.json    # Component → bio.tools registry
│   ├── edam_mapping.json        # Component → EDAM ontology terms
│   ├── tool_catalog.json        # 122 tools from software.config
│   ├── tool_catalog_full.json   # 437 tools from all sources
│   ├── database_catalog.json    # 37 reference databases
│   ├── converter_mapping.json   # 65 converters → components with tool chains
│   └── contributors.json        # 33 contributors
│
├── generated/                   # Translated formats
│   ├── docs/
│   │   └── bco/                 # BioCompute Objects (IEEE 2791)
│   │       ├── components/      # Component BCOs (362)
│   │       └── pipeline_templates/  # Pipeline BCOs (40)
│   │
│   └── wfl-lang/                # Workflow language translations
│       ├── cwl/
│       │   └── components/      # CWL tool definitions (362)
│       ├── ergatis_lite/
│       │   ├── components/      # Component Ergatis Lite notation (362)
│       │   └── pipeline_templates/  # Pipeline template Ergatis Lite (40)
│       └── nextflow/
│           ├── components/      # Nextflow processes (383)
│           └── pipeline_templates/  # Nextflow pipeline workflows (40)
│
├── viewer/                      # Web-based component viewer (HTML/JS)
│
├── tools/                       # EELS Perl scripts
│   ├── workflow_xml_to_json.pl  # Core XML→JSON converter (Brett)
│   ├── simple_to_nextflow.pl    # JSON→Nextflow converter (Brett)
│   ├── categorize_steps.pl      # Step categorizer
│   ├── map_biotools.pl          # bio.tools registry mapper
│   ├── catalog_tools_and_dbs.pl # Tool/database cataloger
│   └── ...
│
├── docs/                        # Documentation
├── CONTRIBUTORS.md
├── PHILOSOPHY.md
└── README.md
```

## Source Material

- **Ergatis source:** `ergatis-eels-devel/ergatis-git/`
- **Components:** `components/` (INI configs) + `workflow/` (XML templates)
- **Converters:** Perl scripts in `src/perl/` with manpages in `man/man1/`
- **Ergatis Lite:** Brett Whitty, JCVI, 2007

## Project Context

**Lead:** Brett Whitty (GNOMATIX), original TIGR developer
**Started:** 2026-02-18

!["GNOMATIX"](assets/images/gnomatix-new-xs.png)
