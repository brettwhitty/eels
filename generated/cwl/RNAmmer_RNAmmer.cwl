cwlVersion: v1.2
class: CommandLineTool
id: RNAmmer_RNAmmer
label: RNAmmer from RNAmmer component
doc: Tool execution from Ergatis RNAmmer component (TIGR/JCVI/IGS)
baseCommand:
- RNAmmer
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
