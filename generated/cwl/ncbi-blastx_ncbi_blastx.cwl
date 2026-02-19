cwlVersion: v1.2
class: CommandLineTool
id: ncbi-blastx_ncbi-blastx
label: ncbi-blastx from ncbi-blastx component
doc: Tool execution from Ergatis ncbi-blastx component (TIGR/JCVI/IGS)
baseCommand:
- ncbi-blastx
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
