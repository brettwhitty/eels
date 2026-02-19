cwlVersion: v1.2
class: CommandLineTool
id: genewise_prepare for genewise
label: prepare for genewise from genewise component
doc: Tool execution from Ergatis genewise component (TIGR/JCVI/IGS)
baseCommand:
- prepare for genewise
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
