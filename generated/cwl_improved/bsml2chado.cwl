cwlVersion: v1.2
class: CommandLineTool
id: bsml2chado
label: bsml2chado
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
  password_file:
    type: string?
    doc: PASSWORD_FILE parameter
  database:
    type: string?
    default: "$;PROJECT$;"
    doc: DATABASE parameter
  server:
    type: string?
    doc: SERVER parameter
  rdbms:
    type: string?
    default: "[postgresql|mysql|sybase|oracle]"
    doc: RDBMS parameter
  skip_load:
    type: string?
    doc: SKIP_LOAD parameter
  refresh_indexes:
    type: int?
    default: 1
    doc: REFRESH_INDEXES parameter
  readonlycache:
    type: int?
    default: 1
    doc: READONLYCACHE parameter
  autogen_feat:
    type: string?
    doc: AUTOGEN_FEAT parameter
  autogen_seq:
    type: string?
    doc: AUTOGEN_SEQ parameter
  insert_new:
    type: int?
    default: 1
    doc: INSERT_NEW parameter
  update:
    type: string?
    doc: UPDATE parameter
  sequence_type:
    type: string?
    default: "[assembly|supercontig]"
    doc: SEQUENCE_TYPE parameter
  email:
    type: string?
    default: "$;USERNAME$;"
    doc: EMAIL parameter
  gzip_bcp:
    type: int?
    default: 1
    doc: GZIP_BCP parameter
  bcp_batch_size:
    type: int?
    default: 30000
    doc: BCP_BATCH_SIZE parameter
  exclude_classes:
    type: string?
    default: "none"
    doc: EXCLUDE_CLASSES parameter
  sort_chunk_size:
    type: int?
    default: 10000000
    doc: SORT_CHUNK_SIZE parameter
  checksum_filenames:
    type: string?
    doc: CHECKSUM_FILENAMES parameter
  no_exec_quota_check:
    type: int?
    default: 1
    doc: NO_EXEC_QUOTA_CHECK parameter
  no_assert_feature_file:
    type: int?
    default: 1
    doc: NO_ASSERT_FEATURE_FILE parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
