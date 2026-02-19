cwlVersion: v1.2
class: CommandLineTool
id: extract_snp_regions_extract_snp_regions
label: extract_snp_regions from extract_snp_regions component
doc: Tool execution from Ergatis extract_snp_regions component (TIGR/JCVI/IGS)
baseCommand:
- extract_snp_regions
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
