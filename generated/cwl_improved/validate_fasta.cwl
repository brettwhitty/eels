cwlVersion: v1.2
class: CommandLineTool
id: validate_fasta
label: validate_fasta
doc: |
  none
  Classification: validation
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [countHeadersWithoutSequence]

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
