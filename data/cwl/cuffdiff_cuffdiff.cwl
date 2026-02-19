cwlVersion: v1.2
class: CommandLineTool
id: cuffdiff_cuffdiff
label: cuffdiff from cuffdiff component
doc: Tool execution from Ergatis cuffdiff component (TIGR/JCVI/IGS)
baseCommand:
- cuffdiff
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
