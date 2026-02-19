cwlVersion: v1.2
class: CommandLineTool
id: ber_rename fixed praze output
label: rename fixed praze output from ber component
doc: Tool execution from Ergatis ber component (TIGR/JCVI/IGS)
baseCommand:
- mv
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
