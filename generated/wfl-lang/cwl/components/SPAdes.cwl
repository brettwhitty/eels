cwlVersion: v1.2
class: CommandLineTool
id: SPAdes
label: SPAdes
doc: |
  none
  Classification: assembly
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
  spades_bin:
    type: string?
    doc: SPADES_BIN parameter

outputs:
  fsa_output:
    type: File
    outputBinding:
      glob: "*.fsa"
    doc: fsa format output
