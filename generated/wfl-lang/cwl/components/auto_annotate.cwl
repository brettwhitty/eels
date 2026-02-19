cwlVersion: v1.2
class: CommandLineTool
id: auto_annotate
label: auto_annotate
doc: |
  none
  Classification: functional prediction
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [auto_annotate]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  hmm_analysis:
    type: string?
    doc: HMM_ANALYSIS parameter
  ber_analysis:
    type: string?
    doc: BER_ANALYSIS parameter
  hmm_info_db:
    type: string?
    doc: HMM_INFO_DB parameter
  panda_header_offsets:
    type: string?
    doc: PANDA_HEADER_OFFSETS parameter
  panda_header_file:
    type: string?
    doc: PANDA_HEADER_FILE parameter
  role_info_db:
    type: string?
    doc: ROLE_INFO_DB parameter
  percent_id_cutoff:
    type: int?
    default: 35
    doc: PERCENT_ID_CUTOFF parameter
  length_cutoff:
    type: int?
    default: 80
    doc: LENGTH_CUTOFF parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
