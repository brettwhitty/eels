cwlVersion: v1.2
class: CommandLineTool
id: samtools_alignment_stats_samtools_alignment_stats
label: samtools_alignment_stats from samtools_alignment_stats component
doc: Tool execution from Ergatis samtools_alignment_stats component (TIGR/JCVI/IGS)
baseCommand:
- samtools_alignment_stats
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
