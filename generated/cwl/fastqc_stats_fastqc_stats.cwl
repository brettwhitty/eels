cwlVersion: v1.2
class: CommandLineTool
id: fastqc_stats_fastqc_stats
label: fastqc_stats from fastqc_stats component
doc: Tool execution from Ergatis fastqc_stats component (TIGR/JCVI/IGS)
baseCommand:
- fastqc_stats
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
