cwlVersion: v1.2
class: CommandLineTool
id: chado_report_pages
label: chado_report_pages
doc: |
  none
  Classification: database / extraction
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
    default: "chado_admin"
    doc: USERNAME parameter
  password:
    type: string?
    default: "chado_admin99"
    doc: PASSWORD parameter
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
    default: "SYBPROD"
    doc: SERVER parameter
  model_list_file:
    type: string?
    doc: MODEL_LIST_FILE parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
