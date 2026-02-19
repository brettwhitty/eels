cwlVersion: v1.2
class: CommandLineTool
id: pangenome_make_profile
label: pangenome_make_profile
doc: |
  Creates a profile matrix showing the genes that have BLAST hits for each genome
  Classification: unclassified
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
