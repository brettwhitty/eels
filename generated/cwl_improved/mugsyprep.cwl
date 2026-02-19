cwlVersion: v1.2
class: CommandLineTool
id: mugsyprep
label: mugsyprep
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
  use_polypeptides:
    type: string?
    doc: USE_POLYPEPTIDES parameter

outputs:
  bcp_output:
    type: File
    outputBinding:
      glob: "*.bcp"
    doc: bcp format output
