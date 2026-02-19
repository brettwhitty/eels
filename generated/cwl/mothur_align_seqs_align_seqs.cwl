cwlVersion: v1.2
class: CommandLineTool
id: mothur_align_seqs_align seqs
label: align seqs from mothur_align_seqs component
doc: Tool execution from Ergatis mothur_align_seqs component (TIGR/JCVI/IGS)
baseCommand:
- align seqs
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
