cwlVersion: v1.2
class: CommandLineTool
id: ksnp_ksnp
label: ksnp from ksnp component
doc: Tool execution from Ergatis ksnp component (TIGR/JCVI/IGS)
baseCommand:
- ksnp
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
