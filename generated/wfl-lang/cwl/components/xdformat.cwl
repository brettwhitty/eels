cwlVersion: v1.2
class: CommandLineTool
id: xdformat
label: xdformat
doc: |
  none
  Classification: file / indexing
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
  seq_type:
    type: string?
    default: "p"
    doc: SEQ_TYPE parameter
  precision:
    type: int?
    default: 4
    doc: PRECISION parameter
  other_opts:
    type: string?
    default: "-I -k"
    doc: OTHER_OPTS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
