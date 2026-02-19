cwlVersion: v1.2
class: CommandLineTool
id: clustalw_validate clustalw output
label: validate clustalw output from clustalw component
doc: Tool execution from Ergatis clustalw component (TIGR/JCVI/IGS)
baseCommand:
- validate clustalw output
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
