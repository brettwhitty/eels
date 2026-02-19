cwlVersion: v1.2
class: CommandLineTool
id: nucmer_create group temp folder
label: create group temp folder from nucmer component
doc: Tool execution from Ergatis nucmer component (TIGR/JCVI/IGS)
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
