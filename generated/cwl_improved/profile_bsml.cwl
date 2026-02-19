cwlVersion: v1.2
class: CommandLineTool
id: profile_bsml
label: profile_bsml
doc: |
  none
  Classification: profile
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

outputs:
  prof_output:
    type: File
    outputBinding:
      glob: "*.prof"
    doc: prof format output
