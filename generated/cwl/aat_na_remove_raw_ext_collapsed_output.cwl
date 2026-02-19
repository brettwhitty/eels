cwlVersion: v1.2
class: CommandLineTool
id: aat_na_remove raw ext collapsed output
label: remove raw ext collapsed output from aat_na component
doc: Tool execution from Ergatis aat_na component (TIGR/JCVI/IGS)
baseCommand:
- rm
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
