cwlVersion: v1.2
class: CommandLineTool
id: assign_dbxref_ids
label: assign_dbxref_ids
doc: |
  Assign ID prefixes to dbxref table in database
  Classification: utility
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [assign_dbxref_ids]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  server:
    type: string?
    doc: SERVER parameter
  username:
    type: string?
    doc: USERNAME parameter
  password:
    type: string?
    doc: PASSWORD parameter
  password_file:
    type: string?
    doc: PASSWORD_FILE parameter
  db_name:
    type: string?
    default: "NCBI_locus_tag"
    doc: DB_NAME parameter
  id_prefix_map:
    type: string?
    doc: ID_PREFIX_MAP parameter
  feature_type:
    type: string?
    default: "gene"
    doc: FEATURE_TYPE parameter
  organism_id:
    type: string?
    doc: ORGANISM_ID parameter
  assign_missing:
    type: string?
    doc: ASSIGN_MISSING parameter
  version:
    type: string?
    default: "public_locus"
    doc: VERSION parameter
  zero_pad:
    type: int?
    default: 4
    doc: ZERO_PAD parameter
  molecule_type:
    type: string?
    default: "assembly"
    doc: MOLECULE_TYPE parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
