cwlVersion: v1.2
class: CommandLineTool
id: auto_annotate_auto annotate compute
label: auto annotate compute from auto_annotate component
doc: Tool execution from Ergatis auto_annotate component (TIGR/JCVI/IGS)
baseCommand:
- auto annotate compute
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
