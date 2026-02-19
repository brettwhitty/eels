cwlVersion: v1.2
class: CommandLineTool
id: clustalw_clustalw
label: clustalw from clustalw component
doc: Tool execution from Ergatis clustalw component (TIGR/JCVI/IGS)
baseCommand:
- clustalw
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
