cwlVersion: v1.2
class: CommandLineTool
id: genbank2fasta_create temp directory
label: create temp directory from genbank2fasta component
doc: Tool execution from Ergatis genbank2fasta component (TIGR/JCVI/IGS)
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
