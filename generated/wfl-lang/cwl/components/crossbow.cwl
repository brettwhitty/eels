cwlVersion: v1.2
class: CommandLineTool
id: crossbow
label: crossbow
doc: |
  Ergatis component: crossbow
  Classification: alignment
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
  snps_output:
    type: File
    outputBinding:
      glob: "*.snps"
    doc: snps format output
