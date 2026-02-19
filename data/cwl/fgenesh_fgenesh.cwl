cwlVersion: v1.2
class: CommandLineTool
id: fgenesh_fgenesh
label: fgenesh from fgenesh component
doc: Tool execution from Ergatis fgenesh component (TIGR/JCVI/IGS)
baseCommand:
- fgenesh
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
