cwlVersion: v1.2
class: CommandLineTool
id: snap_snap
label: snap from snap component
doc: Tool execution from Ergatis snap component (TIGR/JCVI/IGS)
baseCommand:
- snap
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
