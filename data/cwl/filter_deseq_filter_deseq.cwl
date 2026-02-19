cwlVersion: v1.2
class: CommandLineTool
id: filter_deseq_filter_deseq
label: filter_deseq from filter_deseq component
doc: Tool execution from Ergatis filter_deseq component (TIGR/JCVI/IGS)
baseCommand:
- filter_deseq
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
