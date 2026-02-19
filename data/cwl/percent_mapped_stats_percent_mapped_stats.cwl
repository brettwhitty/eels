cwlVersion: v1.2
class: CommandLineTool
id: percent_mapped_stats_percent_mapped_stats
label: percent_mapped_stats from percent_mapped_stats component
doc: Tool execution from Ergatis percent_mapped_stats component (TIGR/JCVI/IGS)
baseCommand:
- percent_mapped_stats
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
