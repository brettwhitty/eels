# BioCompute Object (BCO) Mapping for Ergatis

## Overview

BioCompute Object (IEEE 2791-2020) is a standard for representing computational workflows in bioinformatics. This document maps Ergatis components and workflows to BCO structure.

## BCO Structure

### Top-Level Domains

1. **Provenance Domain** - Who created it, when, why
2. **Usability Domain** - Human-readable description
3. **Description Domain** - Pipeline description and keywords
4. **Execution Domain** - Scripts, tools, environment
5. **Parametric Domain** - Input parameters
6. **I/O Domain** - Input and output files
7. **Error Domain** - Error handling and validation

## Ergatis → BCO Mapping

### Component → BCO Step

**Ergatis Component:**
```json
{
  "name": "blast",
  "tool_execution": [
    {"name": "ncbi-blastp", "executable": "$;BLASTALL_EXEC$;"}
  ],
  "converters": {
    "iterator": [
      {"script": "blast2bsml", "input": "*.raw", "output": "*.bsml"}
    ]
  }
}
```

**BCO Execution Domain Step:**
```json
{
  "step_number": 1,
  "name": "BLAST protein alignment",
  "description": "Run NCBI BLASTP against protein database",
  "version": "2.2.26",
  "prerequisite": [],
  "input_list": [
    {"uri": "query.fasta", "access_time": "..."}
  ],
  "output_list": [
    {"uri": "blast.raw", "access_time": "..."},
    {"uri": "blast.bsml", "access_time": "..."}
  ]
}
```

### Workflow → BCO Pipeline

**Ergatis Pipeline XML:**
- CommandSet hierarchy
- Component ordering
- Iterator parallelization

**BCO Execution Domain:**
- Sequential steps
- Script references
- Environment requirements
- Platform information

### Converter → BCO Post-Processing Step

Converters (e.g., `blast2bsml.pl`) become separate BCO steps:

```json
{
  "step_number": 2,
  "name": "Convert BLAST to BSML",
  "description": "Parse BLAST raw output to BSML XML format",
  "version": "1.0",
  "prerequisite": [{"name": "BLAST protein alignment", "uri": "..."}],
  "input_list": [{"uri": "blast.raw"}],
  "output_list": [{"uri": "blast.bsml"}]
}
```

## Key Mappings

### Provenance Domain

- **Contributors**: Map from `CONTRIBUTORS.md` (28 TIGR/JCVI/IGS developers)
- **Created**: Component creation date (from git history)
- **Modified**: Last modification date
- **License**: Artistic License 2.0 (Ergatis license)

### Description Domain

- **Keywords**: Component classification (e.g., "alignment", "pairwise", "protein")
- **Pipeline steps**: Component execution chain
- **Platform**: Linux, Perl 5.x, specific tool versions

### Execution Domain

- **Script**: Component template XML + tool executables
- **Script driver**: TIGR Workflow Engine
- **Software prerequisites**: Tool dependencies (BLAST, HMMer, etc.)
- **Environment variables**: `$;VARIABLE$;` placeholders

### Parametric Domain

- **Input parameters**: Component `.config` INI file parameters
- **Output parameters**: Output file paths and formats

### I/O Domain

- **Input subdomain**: FASTA files, lists, directories
- **Output subdomain**: BSML, BTAB, raw output formats

### Error Domain

- **Empirical error**: Known failure modes
- **Algorithmic error**: Tool-specific error rates

## Iterator → BCO Parallelization

Ergatis iterators create parallel execution:

**Ergatis:**
```xml
<commandSet type="parallel">
  <state>incomplete</state>
  <commandSet type="serial">
    <!-- Process one file -->
  </commandSet>
</commandSet>
```

**BCO:**
```json
{
  "step_number": 1,
  "name": "BLAST (parallelized)",
  "description": "Run BLAST on 150 input sequences in parallel",
  "prerequisite": [],
  "input_list": [
    {"uri": "input_list.txt", "description": "List of 150 FASTA files"}
  ]
}
```

## Translation Strategy

1. **Component-level BCO**: Each Ergatis component → standalone BCO
2. **Pipeline-level BCO**: Complete workflow → BCO with multiple steps
3. **Provenance preservation**: Maintain TIGR/JCVI/IGS attribution
4. **Tool versioning**: Document tool versions from production use
5. **Parameter documentation**: Extract from `.config` files

## Benefits of BCO Format

- **FDA compliance**: IEEE standard for regulatory submissions
- **Human-readable**: JSON format with extensive documentation
- **Provenance tracking**: Built-in attribution and versioning
- **Interoperability**: Standard format across institutions
- **Validation**: Schema validation for correctness

## Next Steps

1. Create BCO schema templates for common component types
2. Extract provenance from git history and CONTRIBUTORS.md
3. Map tool versions from production deployments
4. Generate BCO examples for 3-5 representative components
5. Validate against IEEE 2791-2020 schema

## References

- IEEE 2791-2020: BioCompute Object Standard
- https://docs.biocomputeobject.org/
- Ergatis source: `~/repos/eels/ergatis-eels-devel/ergatis-git/`
