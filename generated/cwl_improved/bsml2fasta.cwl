cwlVersion: v1.2
class: CommandLineTool
id: bsml2fasta
label: bsml2fasta
doc: |
  none
  Classification: file / conversion
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
  format:
    type: string?
    default: "single"
    doc: FORMAT parameter
  seqs_per_fasta:
    type: int?
    default: 100
    doc: SEQS_PER_FASTA parameter
  class_filter:
    type: string?
    doc: CLASS_FILTER parameter
  header_class:
    type: string?
    doc: HEADER_CLASS parameter
  parse_element:
    type: string?
    default: "sequence"
    doc: PARSE_ELEMENT parameter
  role_exclude:
    type: string?
    doc: ROLE_EXCLUDE parameter
  role_include:
    type: string?
    doc: ROLE_INCLUDE parameter
  bp_extension:
    type: string?
    doc: BP_EXTENSION parameter
  coords:
    type: string?
    doc: COORDS parameter
  use_feature_ids_in_fasta:
    type: string?
    doc: USE_FEATURE_IDS_IN_FASTA parameter
  use_sequence_ids_in_fasta:
    type: string?
    doc: USE_SEQUENCE_IDS_IN_FASTA parameter

outputs:
  output_list_output:
    type: File
    outputBinding:
      glob: "*.output_list"
    doc: output_list format output
