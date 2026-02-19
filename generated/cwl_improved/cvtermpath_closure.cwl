cwlVersion: v1.2
class: CommandLineTool
id: cvtermpath_closure
label: cvtermpath_closure
doc: |
  Ergatis component: cvtermpath_closure
  Classification: unclassified
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
  cv_ids:
    type: string?
    doc: CV_IDS parameter
  server:
    type: string?
    default: "SYBTIGR"
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
