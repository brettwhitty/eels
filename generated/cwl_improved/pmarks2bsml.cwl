cwlVersion: v1.2
class: CommandLineTool
id: pmarks2bsml
label: pmarks2bsml
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
  project_abbreviation:
    type: string?
    default: "$;PROJECT$;"
    doc: PROJECT_ABBREVIATION parameter

outputs:
  output_list_output:
    type: File
    outputBinding:
      glob: "*.output_list"
    doc: output_list format output
