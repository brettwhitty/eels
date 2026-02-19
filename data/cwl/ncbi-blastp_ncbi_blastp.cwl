cwlVersion: v1.2
class: CommandLineTool
id: ncbi-blastp_ncbi-blastp
label: ncbi-blastp from ncbi-blastp component
doc: Tool execution from Ergatis ncbi-blastp component (TIGR/JCVI/IGS)
baseCommand:
- ncbi-blastp
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
