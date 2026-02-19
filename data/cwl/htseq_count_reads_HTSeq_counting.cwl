cwlVersion: v1.2
class: CommandLineTool
id: htseq_count_reads_HTSeq counting
label: HTSeq counting from htseq_count_reads component
doc: Tool execution from Ergatis htseq_count_reads component (TIGR/JCVI/IGS)
baseCommand:
- HTSeq counting
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
