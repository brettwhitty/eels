cwlVersion: v1.2
class: CommandLineTool
id: tag_data
label: tag_data
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
  repo_root:
    type: string?
    doc: REPO_ROOT parameter
  pipeline_id:
    type: string?
    doc: PIPELINE_ID parameter
  pipeline_name:
    type: string?
    doc: PIPELINE_NAME parameter
  flatten:
    type: string?
    doc: FLATTEN parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
