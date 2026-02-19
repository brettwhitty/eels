cwlVersion: v1.2
class: CommandLineTool
id: scripture
label: scripture
doc: |
  none
  Classification: rnaseq
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [UNKNOWN]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  alignment:
    type: string?
    doc: ALIGNMENT parameter
  paired_end_file:
    type: string?
    doc: PAIRED_END_FILE parameter
  chrm_size_file:
    type: string?
    doc: CHRM_SIZE_FILE parameter
  chrm_sequence_dir:
    type: string?
    doc: CHRM_SEQUENCE_DIR parameter
  min_splice_support_reads:
    type: int?
    default: 1
    doc: MIN_SPLICE_SUPPORT_READS parameter
  other_scripture_options:
    type: string?
    doc: OTHER_SCRIPTURE_OPTIONS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
