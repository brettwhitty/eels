cwlVersion: v1.2
class: CommandLineTool
id: muscle_muscle
label: muscle from muscle component
doc: Tool execution from Ergatis muscle component (TIGR/JCVI/IGS)
baseCommand:
- muscle
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
