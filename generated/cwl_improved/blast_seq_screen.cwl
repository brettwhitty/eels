cwlVersion: v1.2
class: CommandLineTool
id: blast_seq_screen
label: blast_seq_screen
doc: |
  none
  Classification: sequence manipulation
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
  results_output:
    type: File
    outputBinding:
      glob: "*.results"
    doc: results format output
