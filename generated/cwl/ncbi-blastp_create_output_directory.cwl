cwlVersion: v1.2
class: CommandLineTool
id: ncbi-blastp_create output directory
label: create output directory from ncbi-blastp component
doc: Tool execution from Ergatis ncbi-blastp component
baseCommand:
- mkdir
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
