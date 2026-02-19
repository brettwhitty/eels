cwlVersion: v1.2
class: CommandLineTool
id: make_comparative_circleator_figure_remove_non_unique_snps
label: remove_non_unique_snps from make_comparative_circleator_figure component
doc: Tool execution from Ergatis make_comparative_circleator_figure component (TIGR/JCVI/IGS)
baseCommand:
- remove_non_unique_snps
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
