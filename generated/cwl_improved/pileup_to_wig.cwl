cwlVersion: v1.2
class: CommandLineTool
id: pileup_to_wig
label: pileup_to_wig
doc: |
  parses samtools pileup and outputs a wig file with entries for any base-pairs with coverage
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
