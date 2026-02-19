cwlVersion: v1.2
class: CommandLineTool
id: extract_snp_regions
label: extract_snp_regions
doc: |
  none
  Classification: SNP
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [extract_snp_regions]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  flanking_bases:
    type: int?
    default: 20
    doc: FLANKING_BASES parameter

outputs:
  output_list_output:
    type: File
    outputBinding:
      glob: "*.output_list"
    doc: output_list format output
