cwlVersion: v1.2
class: CommandLineTool
id: identify_human_contaminants
label: identify_human_contaminants
doc: |
  none
  Classification: unclassified
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
  min_coverage:
    type: float?
    default: 0.9
    doc: MIN_COVERAGE parameter
  min_perc_id:
    type: float?
    default: 0.9
    doc: MIN_PERC_ID parameter
  algorithm:
    type: string?
    default: "nucmer"
    doc: ALGORITHM parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
