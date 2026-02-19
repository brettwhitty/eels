cwlVersion: v1.2
class: CommandLineTool
id: velvet_velvetg pre-processing
label: velvetg pre-processing from velvet component
doc: Tool execution from Ergatis velvet component (TIGR/JCVI/IGS)
baseCommand:
- velvetg pre-processing
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
