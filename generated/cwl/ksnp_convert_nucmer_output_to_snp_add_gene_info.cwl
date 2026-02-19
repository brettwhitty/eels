cwlVersion: v1.2
class: CommandLineTool
id: ksnp_convert nucmer output to snp add gene info
label: convert nucmer output to snp add gene info from ksnp component
doc: Tool execution from Ergatis ksnp component (TIGR/JCVI/IGS)
baseCommand:
- convert nucmer output to snp add gene info
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
