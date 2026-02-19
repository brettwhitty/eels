cwlVersion: v1.2
class: CommandLineTool
id: hmmls_fix output file
label: fix output file from hmmls component
doc: Tool execution from Ergatis hmmls component (TIGR/JCVI/IGS)
baseCommand:
- fix output file
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
