cwlVersion: v1.2
class: CommandLineTool
id: piecharts
label: piecharts
doc: |
  none
  Classification: visualization
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [piecharts]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file

outputs:
  results_output:
    type: File
    outputBinding:
      glob: "*.results"
    doc: results format output
