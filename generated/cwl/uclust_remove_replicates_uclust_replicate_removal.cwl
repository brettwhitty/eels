cwlVersion: v1.2
class: CommandLineTool
id: uclust_remove_replicates_uclust replicate removal
label: uclust replicate removal from uclust_remove_replicates component
doc: Tool execution from Ergatis uclust_remove_replicates component (TIGR/JCVI/IGS)
baseCommand:
- uclust replicate removal
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
