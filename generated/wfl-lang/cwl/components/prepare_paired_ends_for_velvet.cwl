cwlVersion: v1.2
class: CommandLineTool
id: prepare_paired_ends_for_velvet
label: prepare_paired_ends_for_velvet
doc: |
  none
  Classification: assembly
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
  velvet_path:
    type: string?
    default: "$;VELVET_INSTALL_DIR$;"
    doc: VELVET_PATH parameter

outputs:
  long_output:
    type: File
    outputBinding:
      glob: "*.long"
    doc: long format output
  short_output:
    type: File
    outputBinding:
      glob: "*.short"
    doc: short format output
