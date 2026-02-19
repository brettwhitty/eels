cwlVersion: v1.2
class: CommandLineTool
id: delete_bcp
label: delete_bcp
doc: |
  Ergatis component: delete_bcp
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
  server:
    type: string?
    doc: SERVER parameter
  database:
    type: string?
    doc: DATABASE parameter
  database_type:
    type: string?
    default: "sybase"
    doc: DATABASE_TYPE parameter
  bcp_extension:
    type: string?
    default: "out"
    doc: BCP_EXTENSION parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
