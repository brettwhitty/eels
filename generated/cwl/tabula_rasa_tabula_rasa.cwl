cwlVersion: v1.2
class: CommandLineTool
id: tabula_rasa_tabula_rasa
label: tabula_rasa from tabula_rasa component
doc: Tool execution from Ergatis tabula_rasa component (TIGR/JCVI/IGS)
baseCommand:
- tabula_rasa
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
