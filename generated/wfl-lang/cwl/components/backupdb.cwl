cwlVersion: v1.2
class: CommandLineTool
id: backupdb
label: backupdb
doc: |
  Ergatis component: backupdb
  Classification: database / utilities
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
    default: "access"
    doc: USERNAME parameter
  password:
    type: string?
    default: "access"
    doc: PASSWORD parameter
  database:
    type: string?
    doc: DATABASE parameter
  server:
    type: string?
    default: "SYBTIGR"
    doc: SERVER parameter
  database_type:
    type: string?
    default: "sybase"
    doc: DATABASE_TYPE parameter
  batchsize:
    type: int?
    default: 30000
    doc: BATCHSIZE parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
