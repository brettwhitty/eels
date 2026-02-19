cwlVersion: v1.2
class: CommandLineTool
id: ncbi-tblastn_ncbi-tblastn
label: ncbi-tblastn from ncbi-tblastn component
doc: Tool execution from Ergatis ncbi-tblastn component (TIGR/JCVI/IGS)
baseCommand:
- ncbi-tblastn
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
