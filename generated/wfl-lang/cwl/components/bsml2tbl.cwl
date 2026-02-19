cwlVersion: v1.2
class: CommandLineTool
id: bsml2tbl
label: bsml2tbl
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
  export_mrna_features:
    type: string?
    doc: EXPORT_MRNA_FEATURES parameter
  all_ec_numbers:
    type: string?
    doc: ALL_EC_NUMBERS parameter
  percent_n_cutoff:
    type: int?
    default: 10
    doc: PERCENT_N_CUTOFF parameter
  other_opts:
    type: string?
    doc: OTHER_OPTS parameter

outputs:
  tbl_output:
    type: File
    outputBinding:
      glob: "*.tbl"
    doc: tbl format output
