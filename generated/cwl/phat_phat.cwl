cwlVersion: v1.2
class: CommandLineTool
id: phat_phat
label: phat from phat component
doc: Tool execution from Ergatis phat component (TIGR/JCVI/IGS)
baseCommand:
- phat
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
