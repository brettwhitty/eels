cwlVersion: v1.2
class: CommandLineTool
id: blast_snp_regions_parse raw BLAST results
label: parse raw BLAST results from blast_snp_regions component
doc: Tool execution from Ergatis blast_snp_regions component (TIGR/JCVI/IGS)
baseCommand:
- parse raw BLAST results
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
