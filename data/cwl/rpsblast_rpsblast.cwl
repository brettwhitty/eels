cwlVersion: v1.2
class: CommandLineTool
id: rpsblast_rpsblast
label: rpsblast from rpsblast component
doc: Tool execution from Ergatis rpsblast component (TIGR/JCVI/IGS)
baseCommand:
- rpsblast
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
