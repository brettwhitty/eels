cwlVersion: v1.2
class: CommandLineTool
id: repeatmasker_repeatmasker
label: repeatmasker from repeatmasker component
doc: Tool execution from Ergatis repeatmasker component (TIGR/JCVI/IGS)
baseCommand:
- repeatmasker
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
