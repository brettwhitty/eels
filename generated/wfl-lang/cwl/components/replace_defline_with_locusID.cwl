cwlVersion: v1.2
class: CommandLineTool
id: replace_defline_with_locusID
label: replace_defline_with_locusID
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

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
