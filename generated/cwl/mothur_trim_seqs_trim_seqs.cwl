cwlVersion: v1.2
class: CommandLineTool
id: mothur_trim_seqs_trim seqs
label: trim seqs from mothur_trim_seqs component
doc: Tool execution from Ergatis mothur_trim_seqs component (TIGR/JCVI/IGS)
baseCommand:
- trim seqs
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
