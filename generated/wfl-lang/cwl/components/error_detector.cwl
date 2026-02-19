cwlVersion: v1.2
class: CommandLineTool
id: error_detector
label: error_detector
doc: |
  none
  Classification: validation
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
  rdbms:
    type: string?
    default: "[postgresql|mysql|sybase|oracle]"
    doc: RDBMS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
