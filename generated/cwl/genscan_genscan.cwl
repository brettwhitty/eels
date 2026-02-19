cwlVersion: v1.2
class: CommandLineTool
id: genscan_genscan
label: genscan from genscan component
doc: Tool execution from Ergatis genscan component (TIGR/JCVI/IGS)
baseCommand:
- genscan
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
