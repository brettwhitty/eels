cwlVersion: v1.2
class: CommandLineTool
id: leech
label: leech
doc: |
  none
  Classification: visualization
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [leech]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  xaxis_name:
    type: string?
    doc: XAXIS_NAME parameter
  yaxis_name:
    type: string?
    doc: YAXIS_NAME parameter
  type:
    type: string?
    default: "l"
    doc: TYPE parameter

outputs:
  results_output:
    type: File
    outputBinding:
      glob: "*.results"
    doc: results format output
