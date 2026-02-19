cwlVersion: v1.2
class: CommandLineTool
id: mothur_cluster_cluster
label: cluster from mothur_cluster component
doc: Tool execution from Ergatis mothur_cluster component (TIGR/JCVI/IGS)
baseCommand:
- cluster
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
