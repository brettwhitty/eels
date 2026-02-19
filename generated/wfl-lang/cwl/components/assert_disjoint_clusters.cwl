cwlVersion: v1.2
class: CommandLineTool
id: assert_disjoint_clusters
label: assert_disjoint_clusters
doc: |
  none
  Classification: cluster analysis
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
  rdbms:
    type: string?
    default: "Sybase"
    doc: RDBMS parameter
  server:
    type: string?
    default: "SYBPROD"
    doc: SERVER parameter
  database:
    type: string?
    default: "$;PROJECT$;"
    doc: DATABASE parameter
  analysis_id:
    type: string?
    doc: ANALYSIS_ID parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
