cwlVersion: v1.2
class: CommandLineTool
id: deseq_deseq
label: deseq from deseq component
doc: Tool execution from Ergatis deseq component (TIGR/JCVI/IGS)
baseCommand:
- deseq
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
