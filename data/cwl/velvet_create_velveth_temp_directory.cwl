cwlVersion: v1.2
class: CommandLineTool
id: velvet_create velveth temp directory
label: create velveth temp directory from velvet component
doc: Tool execution from Ergatis velvet component (TIGR/JCVI/IGS)
baseCommand:
- mkdir
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
