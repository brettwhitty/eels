cwlVersion: v1.2
class: CommandLineTool
id: lgt_mpileup
label: lgt_mpileup
doc: |
  none
  Classification: LGT
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [mkdir]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  fasta_reference:
    type: string?
    doc: FASTA_REFERENCE parameter

outputs:
  mpileup_output:
    type: File
    outputBinding:
      glob: "*.mpileup"
    doc: mpileup format output
