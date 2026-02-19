cwlVersion: v1.2
class: CommandLineTool
id: mumsgraph
label: mumsgraph
doc: |
  none
  Classification: alignment / multiple
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
  coverage_cutoff:
    type: int?
    default: 1
    doc: COVERAGE_CUTOFF parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
