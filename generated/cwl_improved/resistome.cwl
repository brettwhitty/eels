cwlVersion: v1.2
class: CommandLineTool
id: resistome
label: resistome
doc: |
  none
  Classification: file / conversion
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
  identity_percentage:
    type: int?
    default: 30
    doc: IDENTITY_PERCENTAGE parameter
  read_length_coverage:
    type: int?
    default: 80
    doc: READ_LENGTH_COVERAGE parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
