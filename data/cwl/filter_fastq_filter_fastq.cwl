cwlVersion: v1.2
class: CommandLineTool
id: filter_fastq_filter fastq
label: filter fastq from filter_fastq component
doc: Tool execution from Ergatis filter_fastq component (TIGR/JCVI/IGS)
baseCommand:
- filter fastq
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
