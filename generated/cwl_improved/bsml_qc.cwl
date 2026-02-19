cwlVersion: v1.2
class: CommandLineTool
id: bsml_qc
label: bsml_qc
doc: |
  none
  Classification: utility
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [bsml_qc]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  check_dup_polypeptide:
    type: string?
    doc: CHECK_DUP_POLYPEPTIDE parameter
  check_partial:
    type: string?
    doc: CHECK_PARTIAL parameter
  use_pathema_asmbl_id:
    type: string?
    doc: USE_PATHEMA_ASMBL_ID parameter

outputs:
  summary_output:
    type: File
    outputBinding:
      glob: "*.summary"
    doc: summary format output
