cwlVersion: v1.2
class: CommandLineTool
id: RAPSearch2_RAPSearch2
label: RAPSearch2 from RAPSearch2 component
doc: Tool execution from Ergatis RAPSearch2 component (TIGR/JCVI/IGS)
baseCommand:
- RAPSearch2
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
