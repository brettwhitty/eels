cwlVersion: v1.2
class: CommandLineTool
id: validate_chado_records
label: validate_chado_records
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
    default: "$;PROJECT$;"
    doc: DATABASE parameter
  server:
    type: string?
    doc: SERVER parameter
  rdbms:
    type: string?
    default: "sybase"
    doc: RDBMS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
