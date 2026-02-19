cwlVersion: v1.2
class: CommandLineTool
id: muscle_relocate query file
label: relocate query file from muscle component
doc: Tool execution from Ergatis muscle component (TIGR/JCVI/IGS)
baseCommand:
- cp
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
