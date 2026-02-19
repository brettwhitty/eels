cwlVersion: v1.2
class: CommandLineTool
id: sighunt_SigHunt
label: SigHunt from sighunt component
doc: Tool execution from Ergatis sighunt component (TIGR/JCVI/IGS)
baseCommand:
- SigHunt
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
