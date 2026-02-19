cwlVersion: v1.2
class: CommandLineTool
id: p_func
label: p_func
doc: |
  none
  Classification: functional prediction
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
  source_bsml_file:
    type: string?
    doc: SOURCE_BSML_FILE parameter
  feature_relationship_file:
    type: string?
    doc: FEATURE_RELATIONSHIP_FILE parameter
  pseudomolecule_file:
    type: string?
    doc: PSEUDOMOLECULE_FILE parameter
  sort_bin:
    type: string?
    default: "/bin/sort"
    doc: SORT_BIN parameter
  roles_db_dir:
    type: string?
    default: "$;TIGR_ROLES_DB_DIR$;"
    doc: ROLES_DB_DIR parameter
  ec_dat_file:
    type: string?
    default: "$;ENZYME_DAT$;"
    doc: EC_DAT_FILE parameter
  hypothetical:
    type: string?
    doc: HYPOTHETICAL parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
  raw_output:
    type: File
    outputBinding:
      glob: "*.txt"
    doc: raw format output
