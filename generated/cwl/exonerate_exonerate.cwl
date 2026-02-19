cwlVersion: v1.2
class: CommandLineTool
id: exonerate_exonerate
label: exonerate from exonerate component
doc: Tool execution from Ergatis exonerate component (TIGR/JCVI/IGS)
baseCommand:
- exonerate
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
