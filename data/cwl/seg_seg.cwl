cwlVersion: v1.2
class: CommandLineTool
id: seg_seg
label: seg from seg component
doc: Tool execution from Ergatis seg component (TIGR/JCVI/IGS)
baseCommand:
- seg
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
