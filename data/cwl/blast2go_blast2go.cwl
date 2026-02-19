cwlVersion: v1.2
class: CommandLineTool
id: blast2go_blast2go
label: blast2go from blast2go component
doc: Tool execution from Ergatis blast2go component (TIGR/JCVI/IGS)
baseCommand:
- java
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
