cwlVersion: v1.2
class: CommandLineTool
id: alien_hunter
label: alien_hunter
doc: |
  Use longer oligomers in models to find LGT regions, then refine using HMMs
  Classification: LGT
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [alien_hunter]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file

outputs:
  txt_output:
    type: File
    outputBinding:
      glob: "*.txt"
    doc: txt format output
