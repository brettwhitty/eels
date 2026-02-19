cwlVersion: v1.2
class: CommandLineTool
id: elph_elph
label: elph from elph component
doc: Tool execution from Ergatis elph component (TIGR/JCVI/IGS)
baseCommand:
- elph
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
