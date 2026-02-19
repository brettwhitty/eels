cwlVersion: v1.2
class: CommandLineTool
id: dump_fasta_create agp
label: create agp from dump_fasta component
doc: Tool execution from Ergatis dump_fasta component (TIGR/JCVI/IGS)
baseCommand:
- create agp
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
