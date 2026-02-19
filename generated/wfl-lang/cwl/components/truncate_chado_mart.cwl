cwlVersion: v1.2
class: CommandLineTool
id: truncate_chado_mart
label: truncate_chado_mart
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
  database_type:
    type: string?
    default: "sybase"
    doc: DATABASE_TYPE parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
