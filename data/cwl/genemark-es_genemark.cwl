cwlVersion: v1.2
class: CommandLineTool
id: genemark-es_genemark
label: genemark from genemark-es component
doc: Tool execution from Ergatis genemark-es component (TIGR/JCVI/IGS)
baseCommand:
- genemark
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
