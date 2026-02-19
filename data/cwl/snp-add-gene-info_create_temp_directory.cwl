cwlVersion: v1.2
class: CommandLineTool
id: snp-add-gene-info_create temp directory
label: create temp directory from snp-add-gene-info component
doc: Tool execution from Ergatis snp-add-gene-info component (TIGR/JCVI/IGS)
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
