cwlVersion: v1.2
class: CommandLineTool
id: bmtagger_create temp directory
label: create temp directory from bmtagger component
doc: Tool execution from Ergatis bmtagger component (TIGR/JCVI/IGS)
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
