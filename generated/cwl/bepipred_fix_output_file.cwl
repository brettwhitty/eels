cwlVersion: v1.2
class: CommandLineTool
id: bepipred_fix output file
label: fix output file from bepipred component
doc: Tool execution from Ergatis bepipred component (TIGR/JCVI/IGS)
baseCommand:
- fix output file
inputs:
  input_file:
    type: File
    inputBinding:
      position: 1
outputs:
  output_file:
    type: File
    outputBinding:
      glob: '*.out'
