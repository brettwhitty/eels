cwlVersion: v1.2
class: CommandLineTool
id: split_fasta_fastq_split_fasta_fastq
label: split_fasta_fastq from split_fasta_fastq component
doc: Tool execution from Ergatis split_fasta_fastq component (TIGR/JCVI/IGS)
baseCommand:
- split_fasta_fastq
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
