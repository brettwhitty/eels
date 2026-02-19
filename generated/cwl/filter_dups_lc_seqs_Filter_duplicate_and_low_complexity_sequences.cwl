cwlVersion: v1.2
class: CommandLineTool
id: filter_dups_lc_seqs_Filter duplicate and low complexity sequences
label: Filter duplicate and low complexity sequences from filter_dups_lc_seqs component
doc: Tool execution from Ergatis filter_dups_lc_seqs component (TIGR/JCVI/IGS)
baseCommand:
- Filter duplicate and low complexity sequences
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
