cwlVersion: v1.2
class: CommandLineTool
id: histogram_stacked_Stacked histogram visualization
label: Stacked histogram visualization from histogram_stacked component
doc: Tool execution from Ergatis histogram_stacked component (TIGR/JCVI/IGS)
baseCommand:
- Stacked histogram visualization
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
