cwlVersion: v1.2
class: CommandLineTool
id: elph_create group output directory
label: create group output directory from elph component
doc: Tool execution from Ergatis elph component (TIGR/JCVI/IGS)
baseCommand:
- mkdir
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
