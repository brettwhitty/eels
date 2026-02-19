cwlVersion: v1.2
class: CommandLineTool
id: metastats
label: metastats
doc: |
  none
  Classification: comparative
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [metastats]

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
