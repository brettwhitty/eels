cwlVersion: v1.2
class: CommandLineTool
id: fastx_quality_stats_fastx_quality_stats
label: fastx_quality_stats from fastx_quality_stats component
doc: Tool execution from Ergatis fastx_quality_stats component (TIGR/JCVI/IGS)
baseCommand:
- fastx_quality_stats
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
