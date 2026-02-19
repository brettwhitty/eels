cwlVersion: v1.2
class: CommandLineTool
id: cummerbund_cummerbund
label: cummerbund from cummerbund component
doc: Tool execution from Ergatis cummerbund component (TIGR/JCVI/IGS)
baseCommand:
- cummerbund
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
