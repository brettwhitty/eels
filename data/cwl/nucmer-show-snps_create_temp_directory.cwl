cwlVersion: v1.2
class: CommandLineTool
id: nucmer-show-snps_create temp directory
label: create temp directory from nucmer-show-snps component
doc: Tool execution from Ergatis nucmer-show-snps component (TIGR/JCVI/IGS)
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
