cwlVersion: v1.2
class: CommandLineTool
id: alien_hunter_alien_hunter
label: alien_hunter from alien_hunter component
doc: Tool execution from Ergatis alien_hunter component (TIGR/JCVI/IGS)
baseCommand:
- alien_hunter
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
