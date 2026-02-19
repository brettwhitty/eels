cwlVersion: v1.2
class: CommandLineTool
id: intergenic_analysis_intergenic_analysis
label: intergenic_analysis from intergenic_analysis component
doc: Tool execution from Ergatis intergenic_analysis component (TIGR/JCVI/IGS)
baseCommand:
- intergenic_analysis
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
