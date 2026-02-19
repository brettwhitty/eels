cwlVersion: v1.2
class: CommandLineTool
id: nucmer_snps_NUCmer
label: NUCmer from nucmer_snps component
doc: Tool execution from Ergatis nucmer_snps component (TIGR/JCVI/IGS)
baseCommand:
- /usr/local/common/nucmer
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
