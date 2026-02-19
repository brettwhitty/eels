cwlVersion: v1.2
class: CommandLineTool
id: clean_fasta_create clean_fasta directory
label: create clean_fasta directory from clean_fasta component
doc: Tool execution from Ergatis clean_fasta component (TIGR/JCVI/IGS)
baseCommand:
- mkdir
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
