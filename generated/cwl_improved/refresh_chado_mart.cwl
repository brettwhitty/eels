cwlVersion: v1.2
class: CommandLineTool
id: refresh_chado_mart
label: refresh_chado_mart
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
  rdbms:
    type: string?
    default: "sybase"
    doc: RDBMS parameter
  username:
    type: string?
    doc: USERNAME parameter
  password:
    type: string?
    doc: PASSWORD parameter
  gzip_bcp:
    type: int?
    default: 1
    doc: GZIP_BCP parameter
  blast_analysis_id:
    type: string?
    doc: BLAST_ANALYSIS_ID parameter
  cluster_analysis_id:
    type: string?
    doc: CLUSTER_ANALYSIS_ID parameter
  program:
    type: string?
    doc: PROGRAM parameter
  bcp_batch_size:
    type: int?
    default: 30000
    doc: BCP_BATCH_SIZE parameter
  use_cm_blast:
    type: string?
    doc: USE_CM_BLAST parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
