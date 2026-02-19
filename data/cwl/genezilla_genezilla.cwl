cwlVersion: v1.2
class: CommandLineTool
id: genezilla_genezilla
label: genezilla from genezilla component
doc: Tool execution from Ergatis genezilla component (TIGR/JCVI/IGS)
baseCommand:
- genezilla
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
