cwlVersion: v1.2
class: CommandLineTool
id: ksnp_parse reference fasta header
label: parse reference fasta header from ksnp component
doc: Tool execution from Ergatis ksnp component (TIGR/JCVI/IGS)
baseCommand:
- parse reference fasta header
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
