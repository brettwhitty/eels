cwlVersion: v1.2
class: CommandLineTool
id: wait
label: wait
doc: |
  none
  Classification: utility
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [spin_wait]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  time:
    type: int?
    default: 10
    doc: TIME parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
