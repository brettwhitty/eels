cwlVersion: v1.2
class: CommandLineTool
id: ncbi-tblastx_ncbi-tblastx
label: ncbi-tblastx from ncbi-tblastx component
doc: Tool execution from Ergatis ncbi-tblastx component (TIGR/JCVI/IGS)
baseCommand:
- ncbi-tblastx
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
