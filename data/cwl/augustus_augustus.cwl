cwlVersion: v1.2
class: CommandLineTool
id: augustus_augustus
label: augustus from augustus component
doc: Tool execution from Ergatis augustus component (TIGR/JCVI/IGS)
baseCommand:
- augustus
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
