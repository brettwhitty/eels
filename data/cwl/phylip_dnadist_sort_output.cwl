cwlVersion: v1.2
class: CommandLineTool
id: phylip_dnadist_sort output
label: sort output from phylip_dnadist component
doc: Tool execution from Ergatis phylip_dnadist component (TIGR/JCVI/IGS)
baseCommand:
- sort output
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
