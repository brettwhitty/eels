cwlVersion: v1.2
class: CommandLineTool
id: mothur_screen_seqs_screen seqs
label: screen seqs from mothur_screen_seqs component
doc: Tool execution from Ergatis mothur_screen_seqs component (TIGR/JCVI/IGS)
baseCommand:
- screen seqs
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
