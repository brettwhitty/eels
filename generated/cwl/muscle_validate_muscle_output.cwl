cwlVersion: v1.2
class: CommandLineTool
id: muscle_validate muscle output
label: validate muscle output from muscle component
doc: Tool execution from Ergatis muscle component (TIGR/JCVI/IGS)
baseCommand:
- validate muscle output
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
