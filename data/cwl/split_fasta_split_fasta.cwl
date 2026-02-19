cwlVersion: v1.2
class: CommandLineTool
id: split_fasta_split_fasta
label: split_fasta from split_fasta component
doc: Tool execution from Ergatis split_fasta component (TIGR/JCVI/IGS)
baseCommand:
- split_fasta
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
