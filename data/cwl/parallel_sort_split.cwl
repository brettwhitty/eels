cwlVersion: v1.2
class: CommandLineTool
id: parallel_sort_split
label: split from parallel_sort component
doc: Tool execution from Ergatis parallel_sort component (TIGR/JCVI/IGS)
baseCommand:
- split
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
