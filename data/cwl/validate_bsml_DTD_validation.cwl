cwlVersion: v1.2
class: CommandLineTool
id: validate_bsml_DTD validation
label: DTD validation from validate_bsml component
doc: Tool execution from Ergatis validate_bsml component (TIGR/JCVI/IGS)
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
