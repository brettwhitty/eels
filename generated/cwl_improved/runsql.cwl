cwlVersion: v1.2
class: CommandLineTool
id: runsql
label: runsql
doc: |
  none
  Classification: database / manipulation
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
  username:
    type: string?
    doc: USERNAME parameter
  password:
    type: string?
    doc: PASSWORD parameter
  database:
    type: string?
    doc: DATABASE parameter
  server:
    type: string?
    doc: SERVER parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
