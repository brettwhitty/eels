cwlVersion: v1.2
class: CommandLineTool
id: cluster_mapping
label: cluster_mapping
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
  analysis_id1:
    type: string?
    doc: ANALYSIS_ID1 parameter
  analysis_id2:
    type: string?
    doc: ANALYSIS_ID2 parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
