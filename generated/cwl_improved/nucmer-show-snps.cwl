cwlVersion: v1.2
class: CommandLineTool
id: nucmer-show-snps
label: nucmer-show-snps
doc: |
  none
  Classification: alignment
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [mkdir]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  other_opts:
    type: string?
    doc: OTHER_OPTS parameter

outputs:
  snps_output:
    type: File
    outputBinding:
      glob: "*.snps"
    doc: snps format output
