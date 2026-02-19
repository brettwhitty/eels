cwlVersion: v1.2
class: CommandLineTool
id: align_tophat_stats_align_tophat_stats
label: align_tophat_stats from align_tophat_stats component
doc: Tool execution from Ergatis align_tophat_stats component (TIGR/JCVI/IGS)
baseCommand:
- align_tophat_stats
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
