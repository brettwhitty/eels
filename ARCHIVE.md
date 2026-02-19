# Ergatis Eels Archive Package

## Overview

This archive preserves 20+ years of institutional knowledge from the Ergatis bioinformatics workflow system, developed at TIGR/JCVI/IGS (2003-2008). It represents production-grade, FDA-approved software that created Gold-Standard genome annotations.

## Archive Contents

### Data Extraction

**Components (362 files)**
- `data/components/*.json` - Complete component definitions
- Source: Brett Whitty's 2017 dev-component project
- Includes: tool execution, converters, parameters, outputs

**Workflows (51 files)**
- `data/workflow_structure.json` - Workflow structures (784 steps)
- Production pipelines: pangenome, prokaryotic annotation, eukaryotic annotation

**Converters (91 total)**
- `data/converter_catalog.json` - Complete converter catalog
- `data/converters/*.json` - 65 converter definitions from manpages
- Tool output → BSML, BSML → other formats

**Utilities (472 scripts)**
- `data/utility_catalog.json` - Complete utility catalog
- Supporting scripts for data processing and workflow management

**Contributors (28 people)**
- `data/contributors.json` - Structured contributor data
- `CONTRIBUTORS.md` - Human-readable attribution

### Translation Formats

**Ergatis lite (362 files)**
- `data/ergatis_lite/*.lite` - Minimal component notation
- Hierarchical composition syntax
- Human-readable workflow definitions

**BioCompute Objects (413 files)**
- `data/bco/*.json` - 362 component-level BCO
- `data/workflow_bco/*.json` - 51 workflow-level BCO
- IEEE 2791-2020 compliant
- Complete provenance and regulatory compliance

**Common Workflow Language (402 files)**
- `data/cwl/*.cwl` - CWL CommandLineTool definitions
- Type-safe tool configurations
- One file per tool in tool_execution

### Documentation

**Architecture**
- `ERGATIS_ARCHITECTURE.md` - System architecture and design
- `COMPONENT_ANATOMY.md` - Component structure details
- `ERGATIS_LITE_SPEC.md` - Ergatis lite notation specification

**Translation**
- `TRANSLATION_GUIDE.md` - Complete translation guide
- `TRANSLATION_STRATEGY.md` - Translation approach and rationale
- `BCO_MAPPING.md` - BioCompute Object mapping details

**Formats**
- `BSML_SCHEMA.md` - BSML format reference
- `CONVERTER_REFERENCE.md` - Converter catalog and patterns

**Project**
- `README.md` - Project overview
- `PROJECT_SUMMARY.md` - Comprehensive project summary
- `STATUS.md` - Current status and completion tracking

### Converter Deep Dives

- `docs/converters/blast2bsml-analysis.md` - BLAST converter deep dive
- `docs/converters/hmmpfam2bsml-analysis.md` - HMMer converter analysis
- `docs/converters/glimmer32bsml-analysis.md` - Glimmer3 converter details

## Key Statistics

- **362 components** documented
- **51 workflows** extracted
- **91 converters** cataloged
- **472 utility scripts** inventoried
- **28 contributors** attributed
- **784 workflow steps** analyzed
- **402 CWL tools** generated
- **413 BCO objects** created

## Historical Context

### Timeline
- **2003:** Ergatis development begins at TIGR
- **2006:** Production-ready, downloadable, documented
- **2008:** JCVI merger, continued development
- **2017:** Component JSON extraction (Brett Whitty)
- **2026:** Complete knowledge preservation (this archive)

### Institutions
- **TIGR** (The Institute for Genomic Research)
- **JCVI** (J. Craig Venter Institute)
- **IGS** (Institute for Genome Sciences, University of Maryland)

### Production Use
- Hundreds of Gold-Standard genome annotations
- CAMERA ocean metagenomics project
- Human Microbiome Project (HMP)
- Pangenome analysis pipelines
- FDA-approved annotation workflows

## Advanced Features

### Hierarchical Composition
- Workflows compose components (subworkflows)
- Components compose tools
- Reusable subworkflows as first-class units

### Grid Computing Foundation
- Based on Yu & Buyya (2005), Singh et al. (2005)
- Proper subworkflow composition (lacking in modern tools)
- Multi-day/week pipeline runs with recoverable error states

### Production Infrastructure
- Multi-user HPC/HTPC support
- Complete execution logging
- Resource management and authentication
- Deployment flexibility (laptop to cluster)

### User Interface
- Web UI (AJAX, prototype.js) - Josh Orvis
- Sybil visualization (SVG) - Jonathan Crabtree
- Real-time pipeline monitoring

## Modern Relevance

Ergatis addressed problems that modern workflow systems still struggle with:

1. **Subworkflow Composition:** Proper hierarchical composition vs. flat DAGs
2. **Error Recovery:** Multi-day runs with recoverable states
3. **Execution Logging:** Complete provenance tracking
4. **Multi-user HPC:** Not just cloud scatter/gather

Modern tools (Nextflow, Snakemake) excel at cloud deployment but lack Ergatis's compositional architecture.

## Using This Archive

### For Historical Research
- Study workflow system design from Grid computing era
- Understand production genomics infrastructure (2003-2008)
- Trace evolution of bioinformatics standards

### For Modern Translation
- CWL files provide tool configurations
- BCO objects enable regulatory compliance
- Ergatis lite shows compositional patterns

### For Tool Discovery
- 362 components document bioinformatics tools
- Converter patterns show data transformation approaches
- Workflow structures reveal analysis strategies

## File Formats

### Component JSON
```json
{
  "name": "ncbi-blastp",
  "classification": "alignment / pairwise",
  "tool_execution": [...],
  "converters": {...},
  "output_formats": [...]
}
```

### Ergatis lite
```
<ncbi-blastp> = (
  <ncbi-blastp>,
  <blast2btab>,
  <blast2bsml>
)
```

### BioCompute Object (IEEE 2791-2020)
```json
{
  "object_id": "...",
  "provenance_domain": {...},
  "description_domain": {...},
  "execution_domain": {...}
}
```

### CWL CommandLineTool
```yaml
cwlVersion: v1.2
class: CommandLineTool
baseCommand: [blastall]
inputs: [...]
outputs: [...]
```

## References

### Primary Sources
- Ergatis source code (SourceForge, 2003-2008)
- Component configurations (Brett Whitty, 2017)
- Production workflow templates (TIGR/JCVI/IGS)

### Publications
- Orvis et al. (2010) "Ergatis: a web interface and scalable software system for bioinformatics workflows"
- Yu & Buyya (2005) "A taxonomy of workflow management systems for grid computing"
- Singh et al. (2005) "Workflow task clustering for best effort systems with Pegasus"

### Standards
- IEEE 2791-2020: BioCompute Object specification
- Common Workflow Language (CWL) v1.2
- BSML (Bioinformatic Sequence Markup Language)

## Preservation Goals

1. **Institutional Knowledge:** Capture 20+ years of workflow expertise
2. **Tool Documentation:** Preserve 362 component configurations
3. **Translation:** Enable modern workflow adoption
4. **Attribution:** Credit 28 contributors properly
5. **Regulatory:** Provide BCO for FDA compliance
6. **Education:** Document Grid computing workflow design

## Archive Maintenance

This archive is maintained at:
- **Repository:** https://gitea.gnomatix.com/gnomatix/eels
- **Curator:** Brett Whitty (original TIGR developer)
- **License:** Artistic-2.0 (Ergatis original license)

## Contact

For questions about this archive:
- Brett Whitty <brett@gnomatix.com>
- GNOMATIX (https://gnomatix.com)

## Acknowledgments

This preservation effort honors the work of:
- TIGR Informatics team (2003-2008)
- Ergatis development team
- 28 documented contributors
- Countless users who created Gold-Standard annotations

---

**Archive Version:** 1.0  
**Archive Date:** 2026-02-19  
**Total Files:** 1,623  
**Total Lines:** 68,421  
**Preservation Status:** Complete
