cwlVersion: v1.2
class: CommandLineTool
id: adjust_bsml_coordinates_adjust_bsml_coordinates
label: adjust_bsml_coordinates from adjust_bsml_coordinates component
doc: Tool execution from Ergatis adjust_bsml_coordinates component (TIGR/JCVI/IGS)
baseCommand:
- adjust_bsml_coordinates
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
