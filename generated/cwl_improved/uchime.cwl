cwlVersion: v1.2
class: CommandLineTool
id: uchime
label: uchime
doc: |
  none
  Classification: alignment/classification/quality filtering
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [uchime]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  minh:
    type: float?
    default: 0.3
    doc: MINH parameter
  mindivergence:
    type: float?
    default: 0.5
    doc: MINDIVERGENCE parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
