cwlVersion: v1.2
class: CommandLineTool
id: split_file
label: split_file
doc: |
  Concanate the content of all files in an input file list into a single output file
  Classification: utility
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
  lines_per_file:
    type: string?
    doc: LINES_PER_FILE parameter
  num_files:
    type: int?
    default: 150
    doc: NUM_FILES parameter
  prefix:
    type: string?
    default: "split_file"
    doc: PREFIX parameter

outputs:
  output_list_output:
    type: File
    outputBinding:
      glob: "*.output_list"
    doc: output_list format output
