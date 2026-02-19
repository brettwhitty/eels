cwlVersion: v1.2
class: CommandLineTool
id: align_bowtie_stats_align_bowtie_stats
label: align_bowtie_stats from align_bowtie_stats component
doc: Tool execution from Ergatis align_bowtie_stats component (TIGR/JCVI/IGS)
baseCommand:
- align_bowtie_stats
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
