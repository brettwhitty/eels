cwlVersion: v1.2
class: CommandLineTool
id: pangenome_make_pangenome
label: pangenome_make_pangenome
doc: |
  Reports the total number of genes from a random set of genomes of N-size
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
  multiplicity:
    type: string?
    doc: MULTIPLICITY parameter
  comparisons:
    type: string?
    doc: COMPARISONS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
