cwlVersion: v1.2
class: CommandLineTool
id: wu-blastx_wu-blastx
label: wu-blastx from wu-blastx component
doc: Tool execution from Ergatis wu-blastx component (TIGR/JCVI/IGS)
baseCommand:
- wu-blastx
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
