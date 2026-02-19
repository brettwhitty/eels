cwlVersion: v1.2
class: CommandLineTool
id: prodigal_prodigal
label: prodigal from prodigal component
doc: Tool execution from Ergatis prodigal component (TIGR/JCVI/IGS)
baseCommand:
- prodigal
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
