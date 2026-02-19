cwlVersion: v1.2
class: CommandLineTool
id: restoredb
label: restoredb
doc: |
  Ergatis component: restoredb
  Classification: database / loading
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
  bcp_extension:
    type: string?
    default: "out"
    doc: BCP_EXTENSION parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
