cwlVersion: v1.2
class: CommandLineTool
id: metagene_get_seq_by_metagene
label: get_seq_by_metagene from metagene component
doc: Tool execution from Ergatis metagene component (TIGR/JCVI/IGS)
baseCommand:
- get_seq_by_metagene
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
