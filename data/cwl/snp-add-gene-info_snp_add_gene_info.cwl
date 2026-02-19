cwlVersion: v1.2
class: CommandLineTool
id: snp-add-gene-info_snp-add-gene-info
label: snp-add-gene-info from snp-add-gene-info component
doc: Tool execution from Ergatis snp-add-gene-info component (TIGR/JCVI/IGS)
baseCommand:
- snp-add-gene-info
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
