cwlVersion: v1.2
class: CommandLineTool
id: complete_study_stage
label: complete_study_stage
doc: |
  none
  Classification: utility
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
  study_stage_id:
    type: string?
    doc: STUDY_STAGE_ID parameter
  config:
    type: string?
    doc: CONFIG parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
