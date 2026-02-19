cwlVersion: v1.2
class: CommandLineTool
id: ksnp_remove fsplit dir
label: remove fsplit dir from ksnp component
doc: Tool execution from Ergatis ksnp component (TIGR/JCVI/IGS)
baseCommand:
- rm
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
