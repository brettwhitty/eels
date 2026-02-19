# blast2bsml.pl - BLAST to BSML Converter Analysis

## Overview

**Purpose:** Convert raw WU-BLAST output to BSML XML format for Chado database loading

**Author:** Brett Whitty (bwhitty@tigr.org)

**Input:** Raw BLAST output (WU-BLAST format)

**Output:** BSML XML document with alignment data

## Key Features

### Supported BLAST Programs
- blastn (nucleotide-nucleotide)
- blastp (protein-protein)
- blastx (translated nucleotide-protein)
- tblastn (protein-translated nucleotide)
- tblastx (translated nucleotide-translated nucleotide)

### Molecule Type Mapping
```perl
ref_molecule = {
    'blastn'  => 'na',
    'blastp'  => 'aa',
    'blastx'  => 'na',
    'tblastn' => 'aa',
    'tblastx' => 'na',
}

comp_molecule = {
    'blastn'  => 'na',
    'blastp'  => 'aa',
    'blastx'  => 'aa',
    'tblastn' => 'na',
    'tblastx' => 'na',
}
```

## Command-Line Options

### Required
- `--input, -i` - Raw BLAST output file
- `--output, -o` - Output BSML file
- `--query_file_path, -q` - Full path to query FASTA (for refxref population)
- `--analysis_id, -a` - Analysis identifier (format: `{program}_analysis`)
- `--class, -c` - Sequence type (default: 'assembly')

### Optional
- `--gzip_output, -g` - Compress BSML output
- `--max_hsp_count, -m` - Maximum HSPs per alignment
- `--max_alignment_count, -M` - Maximum alignments per query
- `--pvalue, -p` - Maximum P-value threshold (default: 10)
- `--filter_hsps_for_stats, -F` - Filter HSPs by best Sum(P) for statistics
- `--split, -s` - Split output into one file per query sequence
- `--log, -l` - Log file path
- `--debug, -d` - Debug level

## Dependencies

### Perl Modules
- Bio::SearchIO (BioPerl)
- BSML::BsmlRepository
- BSML::BsmlBuilder
- BSML::BsmlParserTwig
- Ergatis::Logger

## Processing Logic

### 1. Input Parsing
Uses Bio::SearchIO with 'blast' format to parse WU-BLAST output

### 2. HSP Processing
- Iterates through BLAST results
- Extracts High-scoring Segment Pairs (HSPs)
- Applies filtering:
  - P-value threshold
  - Maximum HSP count per alignment
  - Maximum alignment count per query

### 3. BSML Generation
Creates BSML XML structure with:
- Sequence elements (query and subject)
- Alignment elements (seq-pair-alignment)
- HSP elements (seq-pair-run)
- Analysis metadata

### 4. Empty Results Handling
Even with no hits, creates:
- Sequence stub for query
- Analysis link

## BSML Output Structure

(To be documented - requires analysis of BSML generation code)

## Usage in Workflow

Typically called from component iterator templates:
```
$;BLASTALL_EXEC$; [params] > $;OUTPUT_DIRECTORY$;/$;ITER_FILE_BASE$;.raw
blast2bsml.pl -i $;OUTPUT_DIRECTORY$;/$;ITER_FILE_BASE$;.raw \
              -o $;OUTPUT_DIRECTORY$;/$;ITER_FILE_BASE$;.bsml \
              -q $;ITER_FILE_PATH$; \
              -a $;ANALYSIS_ID$;
```

## Notes

- Designed for WU-BLAST output format
- Part of standard Ergatis component library
- Critical converter for alignment-based annotation
- BSML output loaded into Chado via bsml2chado component

## Related Components
- ncbi-blastp, ncbi-blastn, ncbi-blastx, ncbi-tblastn, ncbi-tblastx
- wu-blastp, wu-blastn, wu-blastx, wu-tblastn, wu-tblastx
- bsml2chado (database loader)

## Status
**Analysis Level:** Initial structure documented
**TODO:** Complete BSML generation logic extraction
