cwlVersion: v1.2
class: CommandLineTool
id: create_paired_list_file
label: create_paired_list_file
doc: |
  Generates a paired list file from two associated list files
  Classification: RNA-Seq
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
  sample_info:
    type: string?
    doc: SAMPLE_INFO parameter
  other_args:
    type: string?
    default: "--v"
    doc: OTHER_ARGS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
