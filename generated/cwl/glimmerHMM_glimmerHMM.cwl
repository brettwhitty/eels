cwlVersion: v1.2
class: CommandLineTool
id: glimmerHMM_glimmerHMM
label: glimmerHMM from glimmerHMM component
doc: Tool execution from Ergatis glimmerHMM component (TIGR/JCVI/IGS)
baseCommand:
- glimmerHMM
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
