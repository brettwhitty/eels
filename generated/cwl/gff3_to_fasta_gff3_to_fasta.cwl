cwlVersion: v1.2
class: CommandLineTool
id: gff3_to_fasta_gff3_to_fasta
label: gff3_to_fasta from gff3_to_fasta component
doc: Tool execution from Ergatis gff3_to_fasta component (TIGR/JCVI/IGS)
baseCommand:
- gff3_to_fasta
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
