cwlVersion: v1.2
class: CommandLineTool
id: hmmpfam3_hmmpfam3
label: hmmpfam3 from hmmpfam3 component
doc: Tool execution from Ergatis hmmpfam3 component (TIGR/JCVI/IGS)
baseCommand:
- hmmpfam3
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
