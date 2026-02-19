cwlVersion: v1.2
class: CommandLineTool
id: wait_wait
label: wait from wait component
doc: Tool execution from Ergatis wait component (TIGR/JCVI/IGS)
baseCommand:
- wait
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
