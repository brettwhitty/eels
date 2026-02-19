cwlVersion: v1.2
class: CommandLineTool
id: open_reading_frames
label: open_reading_frames
doc: |
  none
  Classification: feature prediction / ORFs
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [open_reading_frames]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  codon_table:
    type: int?
    default: 11
    doc: CODON_TABLE parameter
  frames:
    type: string?
    doc: FRAMES parameter
  min_orf_size:
    type: int?
    default: 180
    doc: MIN_ORF_SIZE parameter
  max_orf_size:
    type: string?
    doc: MAX_ORF_SIZE parameter
  min_unmasked_size:
    type: int?
    default: 150
    doc: MIN_UNMASKED_SIZE parameter
  beginning_as_start:
    type: int?
    default: 1
    doc: BEGINNING_AS_START parameter
  end_as_stop:
    type: int?
    default: 1
    doc: END_AS_STOP parameter
  assume_stops:
    type: string?
    doc: ASSUME_STOPS parameter
  full_orfs:
    type: string?
    doc: FULL_ORFS parameter
  force_methionine:
    type: string?
    doc: FORCE_METHIONINE parameter
  header_additions:
    type: string?
    doc: HEADER_ADDITIONS parameter
  gzip_output:
    type: int?
    default: 1
    doc: GZIP_OUTPUT parameter

outputs:
  fna_output:
    type: File
    outputBinding:
      glob: "*.fna"
    doc: fna format output
  faa_output:
    type: File
    outputBinding:
      glob: "*.faa"
    doc: faa format output
