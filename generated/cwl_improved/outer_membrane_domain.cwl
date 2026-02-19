cwlVersion: v1.2
class: CommandLineTool
id: outer_membrane_domain
label: outer_membrane_domain
doc: |
  none
  Classification: functional prediction
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [outer_membrane_domain]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  project_name:
    type: string?
    default: "$;PROJECT$;"
    doc: PROJECT_NAME parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
