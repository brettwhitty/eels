cwlVersion: v1.2
class: CommandLineTool
id: genbank2bsml_create temp directory
label: create temp directory from genbank2bsml component
doc: Tool execution from Ergatis genbank2bsml component (TIGR/JCVI/IGS)
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
