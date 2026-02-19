cwlVersion: v1.2
class: CommandLineTool
id: pangenome_make_table
label: pangenome_make_table
doc: |
  none
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
  num_threads:
    type: string?
    doc: NUM_THREADS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
