cwlVersion: v1.2
class: CommandLineTool
id: sort_sam_by_name
label: sort_sam_by_name
doc: |
  uses unix sort to sort a sam file by read name
  Classification: alignment
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [sort_sam_by_name.sh]

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
