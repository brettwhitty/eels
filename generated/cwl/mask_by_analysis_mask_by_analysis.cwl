cwlVersion: v1.2
class: CommandLineTool
id: mask_by_analysis_mask_by_analysis
label: mask_by_analysis from mask_by_analysis component
doc: Tool execution from Ergatis mask_by_analysis component (TIGR/JCVI/IGS)
baseCommand:
- mask_by_analysis
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
