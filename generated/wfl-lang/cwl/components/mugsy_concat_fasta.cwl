cwlVersion: v1.2
class: CommandLineTool
id: mugsy_concat_fasta
label: mugsy_concat_fasta
doc: |
  none
  Classification: alignment / pairwise
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
  fsa_output:
    type: File
    outputBinding:
      glob: "*.fsa"
    doc: fsa format output
