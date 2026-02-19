cwlVersion: v1.2
class: CommandLineTool
id: tblastn_plus_run tblastn+
label: run tblastn+ from tblastn_plus component
doc: Tool execution from Ergatis tblastn_plus component (TIGR/JCVI/IGS)
baseCommand:
- run tblastn+
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
