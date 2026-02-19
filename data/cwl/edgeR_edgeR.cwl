cwlVersion: v1.2
class: CommandLineTool
id: edgeR_edgeR
label: edgeR from edgeR component
doc: Tool execution from Ergatis edgeR component (TIGR/JCVI/IGS)
baseCommand:
- edgeR
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
