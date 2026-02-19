cwlVersion: v1.2
class: CommandLineTool
id: velvet_velveth post-processing
label: velveth post-processing from velvet component
doc: Tool execution from Ergatis velvet component (TIGR/JCVI/IGS)
baseCommand:
- velveth post-processing
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
