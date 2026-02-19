cwlVersion: v1.2
class: CommandLineTool
id: mothur_unique_seq_limit
label: mothur_unique_seq_limit
doc: |
  none
  Classification: utility
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
  seqlimit:
    type: int?
    default: 50000
    doc: SEQLIMIT parameter
  faux_fasta:
    type: string?
    doc: FAUX_FASTA parameter
  faux_names:
    type: string?
    doc: FAUX_NAMES parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
