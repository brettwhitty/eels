cwlVersion: v1.2
class: CommandLineTool
id: adjust_bsml_coordinates
label: adjust_bsml_coordinates
doc: |
  none
  Classification: utility
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [adjust_bsml_coordinates]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  map_dir:
    type: string?
    doc: MAP_DIR parameter
  bsml_list:
    type: string?
    default: "$;INPUT_FILE_LIST$;"
    doc: BSML_LIST parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
