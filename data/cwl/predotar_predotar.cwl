cwlVersion: v1.2
class: CommandLineTool
id: predotar_predotar
label: predotar from predotar component
doc: Tool execution from Ergatis predotar component (TIGR/JCVI/IGS)
baseCommand:
- predotar
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
