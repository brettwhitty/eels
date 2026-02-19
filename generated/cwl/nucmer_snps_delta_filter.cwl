cwlVersion: v1.2
class: CommandLineTool
id: nucmer_snps_delta-filter
label: delta-filter from nucmer_snps component
doc: Tool execution from Ergatis nucmer_snps component (TIGR/JCVI/IGS)
baseCommand:
- /usr/local/common/delta-filter
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
