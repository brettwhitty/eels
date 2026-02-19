cwlVersion: v1.2
class: CommandLineTool
id: create_map_file
label: create_map_file
doc: |
  none
  Classification: file / conversion
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

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
