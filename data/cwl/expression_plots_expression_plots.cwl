cwlVersion: v1.2
class: CommandLineTool
id: expression_plots_expression_plots
label: expression_plots from expression_plots component
doc: Tool execution from Ergatis expression_plots component (TIGR/JCVI/IGS)
baseCommand:
- expression_plots
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
