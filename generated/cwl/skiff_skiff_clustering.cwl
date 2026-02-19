cwlVersion: v1.2
class: CommandLineTool
id: skiff_skiff clustering
label: skiff clustering from skiff component
doc: Tool execution from Ergatis skiff component (TIGR/JCVI/IGS)
baseCommand:
- skiff clustering
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
