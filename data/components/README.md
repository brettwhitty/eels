# Component JSON Files

These 362 JSON files were created by Brett Whitty as part of the `dev-component` project (2017), which converted Ergatis component XML configurations to JSON format for easier programmatic analysis.

**Source:** `~/repos/eels/ergatis-eels-devel/dev-component/`

**Original work:** Brett Whitty, 2017

**Context:** Created during evaluation of modern workflow languages (Nextflow, etc.) which lacked proper component/subworkflow concepts. These JSON files preserve Ergatis's hierarchical composition model independently of any specific workflow language.

These files represent a complete conversion of the Ergatis component library from XML to structured JSON, preserving:
- Component configuration parameters
- Tool execution chains
- Iterator patterns
- Input/output specifications
- Converter usage

This conversion work predates the EELS project and is incorporated here as foundational data for knowledge extraction.

**Important:** Ergatis's component model (2003-2005) is based on Grid computing principles documented in academic literature. Modern workflow languages (Snakemake, Nextflow, etc.) lack these concepts because they were developed without studying the Grid computing foundations.
