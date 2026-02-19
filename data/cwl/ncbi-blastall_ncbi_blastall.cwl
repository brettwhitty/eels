cwlVersion: v1.2
class: CommandLineTool
id: ncbi-blastall_ncbi-blastall
label: ncbi-blastall from ncbi-blastall component
doc: Tool execution from Ergatis ncbi-blastall component (TIGR/JCVI/IGS)
baseCommand:
- ncbi-blastall
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
