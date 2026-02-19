cwlVersion: v1.2
class: CommandLineTool
id: mothur_unique_seqs_unique seqs
label: unique seqs from mothur_unique_seqs component
doc: Tool execution from Ergatis mothur_unique_seqs component (TIGR/JCVI/IGS)
baseCommand:
- unique seqs
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
