cwlVersion: v1.2
class: CommandLineTool
id: uchime_uchime chimera checker
label: uchime chimera checker from uchime component
doc: Tool execution from Ergatis uchime component (TIGR/JCVI/IGS)
baseCommand:
- uchime chimera checker
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
