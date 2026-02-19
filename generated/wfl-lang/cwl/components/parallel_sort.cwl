cwlVersion: v1.2
class: CommandLineTool
id: parallel_sort
label: parallel_sort
doc: |
  none
  Classification: utility
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [split]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  sort_opts:
    type: string?
    default: "-k1,1 -k2,2n"
    doc: SORT_OPTS parameter

outputs:
  output_list_output:
    type: File
    outputBinding:
      glob: "*.output_list"
    doc: output_list format output
