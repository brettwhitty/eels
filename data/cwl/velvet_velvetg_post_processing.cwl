cwlVersion: v1.2
class: CommandLineTool
id: velvet_velvetg post-processing
label: velvetg post-processing from velvet component
doc: Tool execution from Ergatis velvet component (TIGR/JCVI/IGS)
baseCommand:
- velvetg post-processing
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
