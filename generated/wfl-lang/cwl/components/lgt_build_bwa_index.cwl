cwlVersion: v1.2
class: CommandLineTool
id: lgt_build_bwa_index
label: lgt_build_bwa_index
doc: |
  Builds a BWA index for future BWA runs
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
  algorithm:
    type: string?
    doc: ALGORITHM parameter

outputs:
  fsa_output:
    type: File
    outputBinding:
      glob: "*.fsa"
    doc: fsa format output
