cwlVersion: v1.2
class: CommandLineTool
id: tmhmm_tmhmm
label: tmhmm from tmhmm component
doc: Tool execution from Ergatis tmhmm component (TIGR/JCVI/IGS)
baseCommand:
- tmhmm
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
