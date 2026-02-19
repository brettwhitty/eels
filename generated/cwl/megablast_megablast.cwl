cwlVersion: v1.2
class: CommandLineTool
id: megablast_megablast
label: megablast from megablast component
doc: Tool execution from Ergatis megablast component (TIGR/JCVI/IGS)
baseCommand:
- megablast
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
