cwlVersion: v1.2
class: CommandLineTool
id: mugsyalign
label: mugsyalign
doc: |
  none
  Classification: clustering
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
  other_opts:
    type: string?
    default: "--refine"
    doc: OTHER_OPTS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
