cwlVersion: v1.2
class: CommandLineTool
id: mothur_get_oturep
label: mothur_get_oturep
doc: |
  none
  Classification: utility
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [mothur]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  dist_format:
    type: string?
    default: "[ phylip|column ]"
    doc: DIST_FORMAT parameter
  label:
    type: string?
    doc: LABEL parameter
  sorted:
    type: string?
    doc: SORTED parameter
  large:
    type: string?
    doc: LARGE parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
