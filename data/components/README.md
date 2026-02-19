# Component JSON Files

These 362 JSON files were created by Brett Whitty as part of the `dev-component` project (2017), which converted Ergatis component XML configurations to JSON format for programmatic analysis and preservation.

**Source:** `~/repos/eels/ergatis-eels-devel/dev-component/`

**Original work:** Brett Whitty, 2017

**Historical Context:** Ergatis was developed at TIGR/JCVI/IGS (2002-2008), the world leader in producing "Gold-Standard" genome annotations. The system was engineered by talented developers at one of the US's leading Centers of Excellence in Genomics, implementing advanced Grid computing principles for HPC/HTPC environments.

**Advanced Features Preserved:**
- **Hierarchical composition** - Workflows compose components (subworkflows), components compose tools
- **Reusable subworkflows** - Components as first-class compositional units
- **Iterator patterns** - Sophisticated parallelization strategies for batch processing
- **Multi-step execution** - Tool execution, format conversion, validation within single component
- **Data flow management** - Explicit dependencies and file-based communication
- **Grid computing integration** - SGE/Grid Engine scheduling, shared filesystem architecture

These JSON files preserve the complete component library structure:
- Component configuration parameters
- Tool execution chains
- Iterator patterns and parallelization strategies
- Input/output specifications
- Converter usage and data transformations

This conversion work predates the EELS project and serves as foundational data for knowledge extraction and preservation of institutional expertise from the genomics annotation community.
