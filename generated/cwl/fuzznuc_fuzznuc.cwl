cwlVersion: v1.2
class: CommandLineTool
id: fuzznuc_fuzznuc
label: fuzznuc from fuzznuc component
doc: Tool execution from Ergatis fuzznuc component (TIGR/JCVI/IGS)
baseCommand:
- fuzznuc
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
