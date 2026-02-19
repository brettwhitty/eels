cwlVersion: v1.2
class: CommandLineTool
id: chado2bsml_DTD validation
label: DTD validation from chado2bsml component
doc: Tool execution from Ergatis chado2bsml component (TIGR/JCVI/IGS)
baseCommand:
- DTD validation
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
