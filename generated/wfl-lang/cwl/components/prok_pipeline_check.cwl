cwlVersion: v1.2
class: CommandLineTool
id: prok_pipeline_check
label: prok_pipeline_check
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
  include_transcript_level:
    type: string?
    doc: INCLUDE_TRANSCRIPT_LEVEL parameter
  log:
    type: string?
    doc: LOG parameter
  check_pipelineid:
    type: string?
    default: "$;PIPELINEID$;"
    doc: CHECK_PIPELINEID parameter
  check_repository_root:
    type: string?
    default: "$;REPOSITORY_ROOT$;"
    doc: CHECK_REPOSITORY_ROOT parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
