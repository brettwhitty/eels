cwlVersion: v1.2
class: CommandLineTool
id: psortb_tmhmm
label: tmhmm from psortb component
doc: Tool execution from Ergatis psortb component (TIGR/JCVI/IGS)
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
