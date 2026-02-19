cwlVersion: v1.2
class: CommandLineTool
id: mothur_classify_seqs_classify seqs
label: classify seqs from mothur_classify_seqs component
doc: Tool execution from Ergatis mothur_classify_seqs component (TIGR/JCVI/IGS)
baseCommand:
- classify seqs
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
