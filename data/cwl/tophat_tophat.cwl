cwlVersion: v1.2
class: CommandLineTool
id: tophat_tophat
label: tophat from tophat component
doc: Tool execution from Ergatis tophat component (TIGR/JCVI/IGS)
baseCommand:
- tophat
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
