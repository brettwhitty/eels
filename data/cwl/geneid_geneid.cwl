cwlVersion: v1.2
class: CommandLineTool
id: geneid_geneid
label: geneid from geneid component
doc: Tool execution from Ergatis geneid component (TIGR/JCVI/IGS)
baseCommand:
- geneid
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
