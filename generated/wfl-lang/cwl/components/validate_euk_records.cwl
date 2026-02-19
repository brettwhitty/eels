cwlVersion: v1.2
class: CommandLineTool
id: validate_euk_records
label: validate_euk_records
doc: |
  none
  Classification: database validation
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
