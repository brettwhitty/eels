cwlVersion: v1.2
class: CommandLineTool
id: piecharts_Create pie chart
label: Create pie chart from piecharts component
doc: Tool execution from Ergatis piecharts component (TIGR/JCVI/IGS)
baseCommand:
- Create pie chart
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
