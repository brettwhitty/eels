cwlVersion: v1.2
class: CommandLineTool
id: samtools_merge
label: samtools_merge
doc: |
  Merge a list of BAM files
  Classification: LGT
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
  output_list_output:
    type: File
    outputBinding:
      glob: "*.output_list"
    doc: output_list format output
