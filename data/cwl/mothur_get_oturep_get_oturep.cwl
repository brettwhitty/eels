cwlVersion: v1.2
class: CommandLineTool
id: mothur_get_oturep_get oturep
label: get oturep from mothur_get_oturep component
doc: Tool execution from Ergatis mothur_get_oturep component (TIGR/JCVI/IGS)
baseCommand:
- get oturep
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
