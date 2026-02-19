cwlVersion: v1.2
class: CommandLineTool
id: infernal
label: infernal
doc: |
  none
  Classification: feature prediction / genes
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [run_cmsearch]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  other_opts:
    type: string?
    default: "--cut_tc"
    doc: OTHER_OPTS parameter
  sequence_list:
    type: string?
    doc: SEQUENCE_LIST parameter
  annot_bsml_list:
    type: string?
    doc: ANNOT_BSML_LIST parameter
  hmm_cm_table:
    type: string?
    doc: HMM_CM_TABLE parameter
  cm_file:
    type: string?
    default: "$;CM_FILE_PATH$;"
    doc: CM_FILE parameter
  stockholm_path:
    type: string?
    default: "$;RFAM_STOCKHOLM_DIR$;"
    doc: STOCKHOLM_PATH parameter
  default_type:
    type: string?
    doc: DEFAULT_TYPE parameter

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
