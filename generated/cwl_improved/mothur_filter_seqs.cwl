cwlVersion: v1.2
class: CommandLineTool
id: mothur_filter_seqs
label: mothur_filter_seqs
doc: |
  none
  Classification: utility
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [mothur]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  vertical:
    type: string?
    default: "T"
    doc: VERTICAL parameter
  other_options:
    type: string?
    doc: OTHER_OPTIONS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
