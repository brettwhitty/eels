# glimmer32bsml.pl - Glimmer3 to BSML Converter

## Overview

**Purpose:** Convert Glimmer3 gene prediction output to BSML format

**Author:** Kevin Galens (kgalens@tigr.org)

**Input:** Glimmer3 .predict file (raw output)

**Output:** BSML XML with gene predictions

## Glimmer3 Input Format

```
>zma1.assembly.5808
orf00001   319296      174  +1     3.95
orf00002      430      969  +1     3.91
orf00003     1197     1051  -1    12.79
orf00004     1258     1368  +1     6.95
```

**Columns:**
1. orf_id
2. start_position
3. end_position  
4. reading_frame (+1, +2, +3, -1, -2, -3)
5. raw_score

## Key Features

### Circular Molecule Handling
- Glimmer3 finds genes spanning end/beginning (circular molecules)
- Converted to negative coordinates in BSML (left of origin)
- Use `--linear` flag in Glimmer3 for linear sequences

### Coordinate System
- Glimmer3 ranges include stop codon (differs from Glimmer2)
- BSML coordinates renumbered to start at zero
- Maintains strand information from reading frame

### Score Handling
- Raw score from .predict file used
- Differs from .details file (PWM/start codon adjustments)
- Allows direct comparison between predictions

## Command-Line Options

### Required
- `--input_list, -i` - List of Glimmer3 .predict files
- `--input_file, -f` - Single Glimmer3 .predict file
- `--output, -o` - Output BSML file
- `--id_repository, -r` - ID repository for Workflow::IdGenerator
- `--fasta_input, -a` - Original FASTA input to Glimmer3

### Optional
- `--project, -p` - Project identifier
- `--log, -l` - Log file
- `--debug` - Debug level
- `--help, -h` - Help message

## Dependencies

### Perl Modules
- Chado::Gene
- BSML::GenePredictionBsml
- Ergatis::IdGenerator
- Ergatis::Logger
- XML::Simple

## Processing Logic

1. Parse Glimmer3 .predict file
2. Extract ORF predictions with coordinates
3. Handle circular molecule coordinates (negative for wraparound)
4. Generate BSML gene prediction elements
5. Assign temporary IDs (replaced before database insertion)
6. Validate XML output

## BSML Output

Creates gene prediction elements with:
- Sequence reference
- Gene features with coordinates
- Strand information
- Prediction scores
- Analysis metadata

## Usage in Workflow

```
glimmer3 [options] $;INPUT_FASTA$; > $;OUTPUT_DIRECTORY$;/$;ITER_FILE_BASE$;.predict

glimmer32bsml.pl \
  --input_file $;OUTPUT_DIRECTORY$;/$;ITER_FILE_BASE$;.predict \
  --output $;OUTPUT_DIRECTORY$;/$;ITER_FILE_BASE$;.bsml \
  --fasta_input $;INPUT_FASTA$; \
  --id_repository $;PROJECT_ID_REPOSITORY$;
```

## Related Components
- glimmer3 (gene prediction component)
- bsml2chado (database loader)

## Notes
- Standard prokaryotic gene prediction tool
- Part of prokaryotic annotation pipeline
- Handles both circular and linear molecules
- Coordinates adjusted for BSML/Chado compatibility
