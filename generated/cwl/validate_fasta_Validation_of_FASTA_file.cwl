cwlVersion: v1.2
class: CommandLineTool
id: validate_fasta_Validation of FASTA file
label: Validation of FASTA file from validate_fasta component
doc: Tool execution from Ergatis validate_fasta component (TIGR/JCVI/IGS)
baseCommand:
- Validation of FASTA file
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
