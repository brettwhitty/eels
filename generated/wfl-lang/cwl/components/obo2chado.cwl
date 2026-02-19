cwlVersion: v1.2
class: CommandLineTool
id: obo2chado
label: obo2chado
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
  namespace:
    type: string?
    doc: NAMESPACE parameter
  batchsize:
    type: int?
    default: 30000
    doc: BATCHSIZE parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
