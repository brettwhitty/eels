cwlVersion: v1.2
class: CommandLineTool
id: preserve_reads_in_fastq_preserve_reads_in_fastq
label: preserve_reads_in_fastq from preserve_reads_in_fastq component
doc: Tool execution from Ergatis preserve_reads_in_fastq component (TIGR/JCVI/IGS)
baseCommand:
- preserve_reads_in_fastq
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
