cwlVersion: v1.2
class: CommandLineTool
id: initdb
label: initdb
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
  database:
    type: string?
    default: "$;PROJECT$;"
    doc: DATABASE parameter
  server:
    type: string?
    doc: SERVER parameter
  admin_user:
    type: string?
    doc: ADMIN_USER parameter
  admin_pass:
    type: string?
    doc: ADMIN_PASS parameter
  password_file:
    type: string?
    doc: PASSWORD_FILE parameter
  partition:
    type: int?
    default: 1
    doc: PARTITION parameter
  rdbms:
    type: string?
    default: "[postgresql|mysql|oracle|sybase]"
    doc: RDBMS parameter
  namespace:
    type: string?
    doc: NAMESPACE parameter
  batchsize:
    type: int?
    default: 30000
    doc: BATCHSIZE parameter
  allow_duplicates:
    type: int?
    default: 1
    doc: ALLOW_DUPLICATES parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
