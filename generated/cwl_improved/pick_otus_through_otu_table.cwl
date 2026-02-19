cwlVersion: v1.2
class: CommandLineTool
id: pick_otus_through_otu_table
label: pick_otus_through_otu_table
doc: |
  none
  Classification: phylogenetic
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
  qiime_path:
    type: string?
    default: "/opt/opt-packages/bioinf-v1r4b1/qiime"
    doc: QIIME_PATH parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
