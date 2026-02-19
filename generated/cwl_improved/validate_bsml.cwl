cwlVersion: v1.2
class: CommandLineTool
id: validate_bsml
label: validate_bsml
doc: |
  none
  Classification: validation
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [dtdValid.pl]

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
