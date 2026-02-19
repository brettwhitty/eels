cwlVersion: v1.2
class: CommandLineTool
id: nucmer-snp2merged
label: nucmer-snp2merged
doc: |
  none
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
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
