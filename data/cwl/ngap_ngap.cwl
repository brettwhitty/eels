cwlVersion: v1.2
class: CommandLineTool
id: ngap_ngap
label: ngap from ngap component
doc: Tool execution from Ergatis ngap component (TIGR/JCVI/IGS)
baseCommand:
- ngap
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
