cwlVersion: v1.2
class: CommandLineTool
id: rpkm_coverage_stats_rpkm_coverage_stats
label: rpkm_coverage_stats from rpkm_coverage_stats component
doc: Tool execution from Ergatis rpkm_coverage_stats component (TIGR/JCVI/IGS)
baseCommand:
- rpkm_coverage_stats
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
