cwlVersion: v1.2
class: CommandLineTool
id: train_for_glimmer3_iteration
label: train_for_glimmer3_iteration
doc: |
  none
  Classification: utility
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
  glimmer3_output_token:
    type: string?
    default: "default"
    doc: GLIMMER3_OUTPUT_TOKEN parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
