cwlVersion: v1.2
class: CommandLineTool
id: extract_assembly_stats_extract_assembly_stats
label: extract_assembly_stats from extract_assembly_stats component
doc: Tool execution from Ergatis extract_assembly_stats component (TIGR/JCVI/IGS)
baseCommand:
- extract_assembly_stats
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
