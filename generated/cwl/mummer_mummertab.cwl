cwlVersion: v1.2
class: CommandLineTool
id: mummer_mummertab
label: mummertab from mummer component
doc: Tool execution from Ergatis mummer component (TIGR/JCVI/IGS)
baseCommand:
- mummertab
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
