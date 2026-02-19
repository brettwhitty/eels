cwlVersion: v1.2
class: CommandLineTool
id: start_site_curation
label: start_site_curation
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
  ber_evidence:
    type: string?
    doc: BER_EVIDENCE parameter
  characterized_db:
    type: string?
    default: "$;CHAR_DB$;"
    doc: CHARACTERIZED_DB parameter
  db_username:
    type: string?
    doc: DB_USERNAME parameter
  db_password:
    type: string?
    doc: DB_PASSWORD parameter
  hmm_coding_db:
    type: string?
    default: "$;HMM_LIB_DB$;"
    doc: HMM_CODING_DB parameter
  ber_extension:
    type: int?
    default: 300
    doc: BER_EXTENSION parameter
  percent_identity_cutoff:
    type: int?
    default: 60
    doc: PERCENT_IDENTITY_CUTOFF parameter
  p_value_cutoff:
    type: float?
    default: 1e-30
    doc: P_VALUE_CUTOFF parameter
  characterized_vote_bonus:
    type: int?
    default: 4
    doc: CHARACTERIZED_VOTE_BONUS parameter
  min_vote_cutoff:
    type: int?
    default: 2
    doc: MIN_VOTE_CUTOFF parameter
  rbs_sliding_window_size:
    type: int?
    default: 6
    doc: RBS_SLIDING_WINDOW_SIZE parameter
  rbs_ag_percent_cutoff:
    type: int?
    default: 75
    doc: RBS_AG_PERCENT_CUTOFF parameter
  bsml_input_file:
    type: string?
    doc: BSML_INPUT_FILE parameter
  bsml_input_list:
    type: string?
    doc: BSML_INPUT_LIST parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
  only_changed_bsml_output:
    type: File
    outputBinding:
      glob: "*.only_changed_bsml"
    doc: only_changed_bsml format output
