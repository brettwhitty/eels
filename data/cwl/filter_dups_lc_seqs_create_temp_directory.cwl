cwlVersion: v1.2
class: CommandLineTool
id: filter_dups_lc_seqs_create temp directory
label: create temp directory from filter_dups_lc_seqs component
doc: Tool execution from Ergatis filter_dups_lc_seqs component (TIGR/JCVI/IGS)
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
