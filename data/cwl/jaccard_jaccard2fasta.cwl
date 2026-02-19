cwlVersion: v1.2
class: CommandLineTool
id: jaccard_jaccard2fasta
label: jaccard2fasta from jaccard component
doc: Tool execution from Ergatis jaccard component (TIGR/JCVI/IGS)
baseCommand:
- jaccard2fasta
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
