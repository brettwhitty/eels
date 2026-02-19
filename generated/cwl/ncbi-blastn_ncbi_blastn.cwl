cwlVersion: v1.2
class: CommandLineTool
id: ncbi-blastn_ncbi-blastn
label: ncbi-blastn from ncbi-blastn component
doc: Tool execution from Ergatis ncbi-blastn component (TIGR/JCVI/IGS)
baseCommand:
- ncbi-blastn
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
