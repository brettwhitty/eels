cwlVersion: v1.2
class: CommandLineTool
id: cleanse_sgc_database
label: cleanse_sgc_database
doc: |
  none
  Classification: database / manipulation
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [mkdir]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  username:
    type: string?
    default: "tanjad"
    doc: USERNAME parameter
  password:
    type: string?
    default: "tanjad9"
    doc: PASSWORD parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
