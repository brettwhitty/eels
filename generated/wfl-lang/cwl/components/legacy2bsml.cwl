cwlVersion: v1.2
class: CommandLineTool
id: legacy2bsml
label: legacy2bsml
doc: |
  none
  Classification: database / extraction
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [mkdir]

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
  host:
    type: string?
    default: "SYBTIGR"
    doc: HOST parameter
  mode:
    type: int?
    default: 2
    doc: MODE parameter
  idgen_identifier_version:
    type: string?
    doc: IDGEN_IDENTIFIER_VERSION parameter
  email:
    type: string?
    doc: EMAIL parameter
  no_die_null_sequences:
    type: int?
    default: 1
    doc: NO_DIE_NULL_SEQUENCES parameter
  bsml_dtd:
    type: string?
    default: "$;DOCS_DIR$;/bsml3_1.dtd"
    doc: BSML_DTD parameter
  input_id_mapping_directories:
    type: string?
    doc: INPUT_ID_MAPPING_DIRECTORIES parameter
  input_id_mapping_files:
    type: string?
    doc: INPUT_ID_MAPPING_FILES parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
  fasta_output:
    type: File
    outputBinding:
      glob: "*.fasta"
    doc: fasta format output
