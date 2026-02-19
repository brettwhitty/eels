# aragorn2bsml.pl - ARAGORN to BSML Converter

## Overview

**Purpose:** Convert ARAGORN tRNA/tmRNA prediction output to BSML format

**Author:** Kevin Galens (kgalens@tigr.org)

**Input:** ARAGORN raw output (tab-delimited, -w option)

**Output:** BSML XML with tRNA/tmRNA predictions

## ARAGORN Input Format

```
>mmycoides.assembly.1	31
T            c[98341,98417]	35	Cys(gca)
T          c[209233,209310]	35	Phe(gaa)
T          c[209317,209395]	36	Asp(gtc)
T          c[209397,209472]	34	Met(cat)
MN	[889602,890012]	[87,173]	AEKNEENFEMPAFMINNASAGANYMFA**
```

**Format:**
- `T` = tRNA prediction
- `MN` = tmRNA prediction
- Coordinates: `[start,end]` or `c[start,end]` (complement strand)
- Score and amino acid/anticodon information

## Command-Line Options

### Required
- `--input_file, -i` - ARAGORN raw output (generated with -w option)
- `--output, -o` - Output BSML file
- `--id_repository, -r` - ID repository for Ergatis::IdGenerator
- `--fasta_input, -a` - Original FASTA input to ARAGORN

### Optional
- `--project, -p` - Project name (default: 'parse' from input file)
- `--compress_output, -g` - Compress output with gzip
- `--log, -l` - Log file
- `--debug, -d` - Debug level
- `--help, -h` - Help message

## Dependencies

### Perl Modules
- BSML::BsmlBuilder
- Ergatis::IdGenerator
- Ergatis::Logger

## Processing Logic

1. Parse ARAGORN tab-delimited output
2. Identify tRNA vs tmRNA predictions
3. Extract coordinates and strand information
4. Parse amino acid and anticodon data
5. Generate BSML RNA feature elements
6. Assign IDs via Ergatis::IdGenerator
7. Optionally compress output

## BSML Output

Creates RNA feature elements with:
- Feature type (tRNA or tmRNA)
- Genomic coordinates
- Strand information
- Amino acid specificity
- Anticodon sequence
- Prediction scores
- Analysis metadata

## Usage in Workflow

```
aragorn -w $;INPUT_FASTA$; > $;OUTPUT_DIRECTORY$;/$;ITER_FILE_BASE$;.raw

aragorn2bsml.pl \
  --input_file $;OUTPUT_DIRECTORY$;/$;ITER_FILE_BASE$;.raw \
  --output $;OUTPUT_DIRECTORY$;/$;ITER_FILE_BASE$;.bsml \
  --fasta_input $;INPUT_FASTA$; \
  --id_repository $;PROJECT_ID_REPOSITORY$; \
  --project $;PROJECT$;
```

## Related Components
- aragorn (tRNA/tmRNA prediction component)
- bsml2chado (database loader)

## Notes
- ARAGORN detects both tRNA and tmRNA genes
- tmRNA (transfer-messenger RNA) involved in trans-translation
- Standard tool for prokaryotic RNA gene annotation
- Part of structural annotation pipeline
- Handles both strands
