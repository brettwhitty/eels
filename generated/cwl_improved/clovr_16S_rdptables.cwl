cwlVersion: v1.2
class: CommandLineTool
id: clovr_16S_rdptables
label: clovr_16S_rdptables
doc: |
  none
  Classification: file / conversion
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
  table_output:
    type: File
    outputBinding:
      glob: "*.table"
    doc: table format output
  paired_table_output:
    type: File
    outputBinding:
      glob: "*.paired_table"
    doc: paired_table format output
