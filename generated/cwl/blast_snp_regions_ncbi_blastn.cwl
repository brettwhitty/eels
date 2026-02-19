cwlVersion: v1.2
class: CommandLineTool
id: blast_snp_regions_ncbi-blastn
label: ncbi-blastn from blast_snp_regions component
doc: Tool execution from Ergatis blast_snp_regions component (TIGR/JCVI/IGS)
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
