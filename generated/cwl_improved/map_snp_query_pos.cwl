cwlVersion: v1.2
class: CommandLineTool
id: map_snp_query_pos
label: map_snp_query_pos
doc: |
  none
  Classification: snp
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
