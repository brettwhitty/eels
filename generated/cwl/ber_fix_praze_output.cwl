cwlVersion: v1.2
class: CommandLineTool
id: ber_fix praze output
label: fix praze output from ber component
doc: Tool execution from Ergatis ber component (TIGR/JCVI/IGS)
baseCommand:
- fix praze output
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
