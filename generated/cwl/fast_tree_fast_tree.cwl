cwlVersion: v1.2
class: CommandLineTool
id: fast_tree_fast_tree
label: fast_tree from fast_tree component
doc: Tool execution from Ergatis fast_tree component (TIGR/JCVI/IGS)
baseCommand:
- fast_tree
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
