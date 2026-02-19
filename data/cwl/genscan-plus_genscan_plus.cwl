cwlVersion: v1.2
class: CommandLineTool
id: genscan-plus_genscan-plus
label: genscan-plus from genscan-plus component
doc: Tool execution from Ergatis genscan-plus component (TIGR/JCVI/IGS)
baseCommand:
- genscan-plus
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
