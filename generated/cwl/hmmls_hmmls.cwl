cwlVersion: v1.2
class: CommandLineTool
id: hmmls_hmmls
label: hmmls from hmmls component
doc: Tool execution from Ergatis hmmls component (TIGR/JCVI/IGS)
baseCommand:
- hmmls
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
