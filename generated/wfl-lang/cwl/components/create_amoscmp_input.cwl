cwlVersion: v1.2
class: CommandLineTool
id: create_amoscmp_input
label: create_amoscmp_input
doc: |
  none
  Classification: sequence / assembly
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
  fasta_output:
    type: File
    outputBinding:
      glob: "*.fasta"
    doc: fasta format output
  qual_output:
    type: File
    outputBinding:
      glob: "*.qual"
    doc: qual format output
