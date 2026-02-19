cwlVersion: v1.2
class: CommandLineTool
id: hmmpfam_hmmpfam
label: hmmpfam from hmmpfam component
doc: Tool execution from Ergatis hmmpfam component
baseCommand:
- hmmpfam
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
