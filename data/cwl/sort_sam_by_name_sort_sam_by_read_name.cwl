cwlVersion: v1.2
class: CommandLineTool
id: sort_sam_by_name_sort sam by read name
label: sort sam by read name from sort_sam_by_name component
doc: Tool execution from Ergatis sort_sam_by_name component (TIGR/JCVI/IGS)
baseCommand:
- sort sam by read name
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
