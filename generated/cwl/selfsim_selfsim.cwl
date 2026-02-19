cwlVersion: v1.2
class: CommandLineTool
id: selfsim_selfsim
label: selfsim from selfsim component
doc: Tool execution from Ergatis selfsim component (TIGR/JCVI/IGS)
baseCommand:
- selfsim
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
