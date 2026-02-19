cwlVersion: v1.2
class: CommandLineTool
id: glimmer3_glimmer3
label: glimmer3 from glimmer3 component
doc: Tool execution from Ergatis glimmer3 component (TIGR/JCVI/IGS)
baseCommand:
- glimmer3
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
