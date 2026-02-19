cwlVersion: v1.2
class: CommandLineTool
id: hmmls_replace fasta headers
label: replace fasta headers from hmmls component
doc: Tool execution from Ergatis hmmls component (TIGR/JCVI/IGS)
baseCommand:
- replace fasta headers
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
