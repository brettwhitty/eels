cwlVersion: v1.2
class: CommandLineTool
id: htseq_htseq
label: htseq from htseq component
doc: Tool execution from Ergatis htseq component (TIGR/JCVI/IGS)
baseCommand:
- htseq
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
