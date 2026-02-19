cwlVersion: v1.2
class: CommandLineTool
id: 454_mplex_seq_bin_trim
label: 454_mplex_seq_bin_trim
doc: |
  none
  Classification: sequence / manipulation
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
  barcode_file:
    type: string?
    default: "/usr/local/projects/16SrRNA_454Multiplex/barcodes/barcodes-v1.txt"
    doc: BARCODE_FILE parameter
  max_barcode_offset:
    type: int?
    default: 4
    doc: MAX_BARCODE_OFFSET parameter
  reverse_primer:
    type: string?
    default: "CATGCTGCCTCCCGTAGGAGT"
    doc: REVERSE_PRIMER parameter
  max_edit_dist:
    type: int?
    default: 2
    doc: MAX_EDIT_DIST parameter
  forward_primer:
    type: string?
    default: "CTGAGCCAGGATCAAACTCT"
    doc: FORWARD_PRIMER parameter
  trim:
    type: string?
    default: "all"
    doc: TRIM parameter
  min_length:
    type: int?
    default: 200
    doc: MIN_LENGTH parameter

outputs:
  filtered_output:
    type: File
    outputBinding:
      glob: "*.filtered"
    doc: filtered format output
  discarded_output:
    type: File
    outputBinding:
      glob: "*.discarded"
    doc: discarded format output
