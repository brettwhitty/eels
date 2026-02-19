cwlVersion: v1.2
class: CommandLineTool
id: panther_panther
label: panther from panther component
doc: Tool execution from Ergatis panther component (TIGR/JCVI/IGS)
baseCommand:
- panther
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
