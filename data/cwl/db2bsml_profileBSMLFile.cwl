cwlVersion: v1.2
class: CommandLineTool
id: db2bsml_profileBSMLFile
label: profileBSMLFile from db2bsml component
doc: Tool execution from Ergatis db2bsml component (TIGR/JCVI/IGS)
baseCommand:
- profileBSMLFile
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
