cwlVersion: v1.2
class: CommandLineTool
id: predict_operons_predict_operons
label: predict_operons from predict_operons component
doc: Tool execution from Ergatis predict_operons component (TIGR/JCVI/IGS)
baseCommand:
- predict_operons
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
