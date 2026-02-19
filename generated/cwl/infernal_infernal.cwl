cwlVersion: v1.2
class: CommandLineTool
id: infernal_infernal
label: infernal from infernal component
doc: Tool execution from Ergatis infernal component (TIGR/JCVI/IGS)
baseCommand:
- infernal
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
