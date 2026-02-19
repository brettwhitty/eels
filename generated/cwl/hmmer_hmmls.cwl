cwlVersion: v1.2
class: CommandLineTool
id: hmmer_hmmls
label: hmmls from hmmer component
doc: Tool execution from Ergatis hmmer component (TIGR/JCVI/IGS)
baseCommand:
- hmmls
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
