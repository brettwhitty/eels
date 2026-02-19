cwlVersion: v1.2
class: CommandLineTool
id: clean_fasta_clean_fasta
label: clean_fasta from clean_fasta component
doc: Tool execution from Ergatis clean_fasta component (TIGR/JCVI/IGS)
baseCommand:
- clean_fasta
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
