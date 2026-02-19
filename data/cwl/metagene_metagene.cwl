cwlVersion: v1.2
class: CommandLineTool
id: metagene_metagene
label: metagene from metagene component
doc: Tool execution from Ergatis metagene component (TIGR/JCVI/IGS)
baseCommand:
- metagene
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
