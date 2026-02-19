cwlVersion: v1.2
class: CommandLineTool
id: nucmer_nucmer
label: nucmer from nucmer component
doc: Tool execution from Ergatis nucmer component (TIGR/JCVI/IGS)
baseCommand:
- nucmer
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
