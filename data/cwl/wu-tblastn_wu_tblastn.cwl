cwlVersion: v1.2
class: CommandLineTool
id: wu-tblastn_wu-tblastn
label: wu-tblastn from wu-tblastn component
doc: Tool execution from Ergatis wu-tblastn component (TIGR/JCVI/IGS)
baseCommand:
- wu-tblastn
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
