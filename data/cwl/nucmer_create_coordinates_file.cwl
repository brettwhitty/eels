cwlVersion: v1.2
class: CommandLineTool
id: nucmer_create coordinates file
label: create coordinates file from nucmer component
doc: Tool execution from Ergatis nucmer component (TIGR/JCVI/IGS)
baseCommand:
- create coordinates file
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
