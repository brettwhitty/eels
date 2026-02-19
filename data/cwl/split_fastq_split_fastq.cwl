cwlVersion: v1.2
class: CommandLineTool
id: split_fastq_split_fastq
label: split_fastq from split_fastq component
doc: Tool execution from Ergatis split_fastq component (TIGR/JCVI/IGS)
baseCommand:
- split_fastq
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
