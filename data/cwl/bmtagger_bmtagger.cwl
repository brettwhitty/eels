cwlVersion: v1.2
class: CommandLineTool
id: bmtagger_bmtagger
label: bmtagger from bmtagger component
doc: Tool execution from Ergatis bmtagger component (TIGR/JCVI/IGS)
baseCommand:
- bmtagger
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
