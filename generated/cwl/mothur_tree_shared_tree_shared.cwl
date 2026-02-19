cwlVersion: v1.2
class: CommandLineTool
id: mothur_tree_shared_tree shared
label: tree shared from mothur_tree_shared component
doc: Tool execution from Ergatis mothur_tree_shared component (TIGR/JCVI/IGS)
baseCommand:
- tree shared
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
