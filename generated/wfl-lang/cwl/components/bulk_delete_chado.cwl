cwlVersion: v1.2
class: CommandLineTool
id: bulk_delete_chado
label: bulk_delete_chado
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
  analysis_id:
    type: string?
    doc: ANALYSIS_ID parameter
  algorithm:
    type: string?
    doc: ALGORITHM parameter
  feature_id:
    type: string?
    doc: FEATURE_ID parameter
  is_obsolete:
    type: string?
    doc: IS_OBSOLETE parameter
  organism_id:
    type: string?
    doc: ORGANISM_ID parameter
  bcp_batch_size:
    type: int?
    default: 30000
    doc: BCP_BATCH_SIZE parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
