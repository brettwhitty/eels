cwlVersion: v1.2
class: CommandLineTool
id: make_comparative_circleator_figure_make_comparative_circleator_figure
label: make_comparative_circleator_figure from make_comparative_circleator_figure
  component
doc: Tool execution from Ergatis make_comparative_circleator_figure component (TIGR/JCVI/IGS)
baseCommand:
- make_comparative_circleator_figure
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
