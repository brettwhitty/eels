cwlVersion: v1.2
class: CommandLineTool
id: delete_by_bcp
label: delete_by_bcp
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
  database_type:
    type: string?
    default: "sybase"
    doc: DATABASE_TYPE parameter
  server:
    type: string?
    doc: SERVER parameter
  gzip_sql:
    type: string?
    doc: GZIP_SQL parameter
  gzip_bcp:
    type: string?
    doc: GZIP_BCP parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
