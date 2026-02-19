cwlVersion: v1.2
class: CommandLineTool
id: lipop_lipop
label: lipop from lipop component
doc: Tool execution from Ergatis lipop component (TIGR/JCVI/IGS)
baseCommand:
- lipop
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
