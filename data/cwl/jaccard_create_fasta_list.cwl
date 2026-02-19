cwlVersion: v1.2
class: CommandLineTool
id: jaccard_create fasta list
label: create fasta list from jaccard component
doc: Tool execution from Ergatis jaccard component (TIGR/JCVI/IGS)
baseCommand:
- find
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
