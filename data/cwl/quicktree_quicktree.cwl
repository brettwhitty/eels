cwlVersion: v1.2
class: CommandLineTool
id: quicktree_quicktree
label: quicktree from quicktree component
doc: Tool execution from Ergatis quicktree component (TIGR/JCVI/IGS)
baseCommand:
- quicktree
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
