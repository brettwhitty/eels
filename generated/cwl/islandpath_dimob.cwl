cwlVersion: v1.2
class: CommandLineTool
id: islandpath_dimob
label: dimob from islandpath component
doc: Tool execution from Ergatis islandpath component (TIGR/JCVI/IGS)
baseCommand:
- dimob
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
