cwlVersion: v1.2
class: CommandLineTool
id: gff3_to_fasta
label: gff3_to_fasta
doc: |
  none
  Classification: file / conversion
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [gff3_to_fasta]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  type:
    type: string?
    default: "cds"
    doc: TYPE parameter
  sequence_type:
    type: string?
    doc: SEQUENCE_TYPE parameter

outputs:
  fasta_output:
    type: File
    outputBinding:
      glob: "*.fasta"
    doc: fasta format output
