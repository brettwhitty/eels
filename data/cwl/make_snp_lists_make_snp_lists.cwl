cwlVersion: v1.2
class: CommandLineTool
id: make_snp_lists_make_snp_lists
label: make_snp_lists from make_snp_lists component
doc: Tool execution from Ergatis make_snp_lists component (TIGR/JCVI/IGS)
baseCommand:
- make_snp_lists
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
