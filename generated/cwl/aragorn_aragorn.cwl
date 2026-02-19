cwlVersion: v1.2
class: CommandLineTool
id: aragorn_aragorn
label: aragorn from aragorn component
doc: Tool execution from Ergatis aragorn component (TIGR/JCVI/IGS)
baseCommand:
- aragorn
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
