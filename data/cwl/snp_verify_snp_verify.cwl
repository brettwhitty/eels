cwlVersion: v1.2
class: CommandLineTool
id: snp_verify_snp_verify
label: snp_verify from snp_verify component
doc: Tool execution from Ergatis snp_verify component (TIGR/JCVI/IGS)
baseCommand:
- snp_verify
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
