cwlVersion: v1.2
class: CommandLineTool
id: basic_alignment_stats_samtools idxstats
label: samtools idxstats from basic_alignment_stats component
doc: Tool execution from Ergatis basic_alignment_stats component (TIGR/JCVI/IGS)
baseCommand:
- samtools idxstats
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
