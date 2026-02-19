cwlVersion: v1.2
class: CommandLineTool
id: cuffdiff_filter_cuffdiff_filter
label: cuffdiff_filter from cuffdiff_filter component
doc: Tool execution from Ergatis cuffdiff_filter component (TIGR/JCVI/IGS)
baseCommand:
- cuffdiff_filter
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
