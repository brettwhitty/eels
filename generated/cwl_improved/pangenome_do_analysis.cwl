cwlVersion: v1.2
class: CommandLineTool
id: pangenome_do_analysis
label: pangenome_do_analysis
doc: |
  none
  Classification: unclassified
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [pangenome_blast_parse]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  write_lists:
    type: string?
    doc: WRITE_LISTS parameter
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
