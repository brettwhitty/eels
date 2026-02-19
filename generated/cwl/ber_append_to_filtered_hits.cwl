cwlVersion: v1.2
class: CommandLineTool
id: ber_append to filtered hits
label: append to filtered hits from ber component
doc: Tool execution from Ergatis ber component (TIGR/JCVI/IGS)
baseCommand:
- cat
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
