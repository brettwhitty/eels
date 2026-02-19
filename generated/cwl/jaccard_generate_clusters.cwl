cwlVersion: v1.2
class: CommandLineTool
id: jaccard_generate clusters
label: generate clusters from jaccard component
doc: Tool execution from Ergatis jaccard component (TIGR/JCVI/IGS)
baseCommand:
- generate clusters
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
