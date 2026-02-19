cwlVersion: v1.2
class: CommandLineTool
id: filter_lgt_class_c_genes
label: filter_lgt_class_c_genes
doc: |
  none
  Classification: LGT
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
  bitscore_thresh:
    type: int?
    default: 100
    doc: BITSCORE_THRESH parameter
  hscore_thresh:
    type: int?
    default: 30
    doc: HSCORE_THRESH parameter

outputs:
  output_list_output:
    type: File
    outputBinding:
      glob: "*.output_list"
    doc: output_list format output
