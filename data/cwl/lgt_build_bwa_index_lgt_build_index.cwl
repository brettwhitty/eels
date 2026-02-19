cwlVersion: v1.2
class: CommandLineTool
id: lgt_build_bwa_index_lgt_build_index
label: lgt_build_index from lgt_build_bwa_index component
doc: Tool execution from Ergatis lgt_build_bwa_index component (TIGR/JCVI/IGS)
baseCommand:
- lgt_build_index
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
