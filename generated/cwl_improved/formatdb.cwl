cwlVersion: v1.2
class: CommandLineTool
id: formatdb
label: formatdb
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
  protein:
    type: string?
    default: "T"
    doc: PROTEIN parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
