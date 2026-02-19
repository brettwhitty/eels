cwlVersion: v1.2
class: CommandLineTool
id: split_multifasta_split_multifasta
label: split_multifasta from split_multifasta component
doc: Tool execution from Ergatis split_multifasta component (TIGR/JCVI/IGS)
baseCommand:
- split_multifasta
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
