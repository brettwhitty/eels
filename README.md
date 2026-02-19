# EELS - Ergatis Extended Lifetime Support

Systematic extraction and documentation of Ergatis component knowledge.

!["EELS!"](assets/images/eels-banner-m.png "EELS!")

## Goal

Extract the institutional knowledge encoded in Ergatis components, workflows, and engineering
decisions in structured, complete, and industry-standard abstract data formats.

Provide tooling to allow applying this knowledge and engineering into other workflow formats
or applications. (And even back to Ergatis component / workflow format, as a proof of design.)

## Approach

1. **Extract** - Parse all `*2bsml.pl` converters for tool semantics
2. **Document** - Build structured catalog of components
3. **Analyze** - Identify parallelization patterns and data flows
4. **Translate** - Map to CWL/Nextflow/WDL equivalents

## Directory Structure

- `scripts/` - Extraction and analysis scripts
- `data/` - Extracted component metadata (JSON/YAML)
- `docs/` - Generated documentation
- `catalog/` - Component catalog organized by function

## Status

**Phase 1: Discovery** - Cataloging existing components and converters

Started: 2026-02-18
