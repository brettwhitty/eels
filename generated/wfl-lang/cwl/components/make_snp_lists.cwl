cwlVersion: v1.2
class: CommandLineTool
id: make_snp_lists
label: make_snp_lists
doc: |
  none
  Classification: SNP
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [make_snp_lists]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file

outputs:
  output_list_output:
    type: File
    outputBinding:
      glob: "*.output_list"
    doc: output_list format output
