cwlVersion: v1.2
class: CommandLineTool
id: fastx_trimming_fastx_trimming
label: fastx_trimming from fastx_trimming component
doc: Tool execution from Ergatis fastx_trimming component (TIGR/JCVI/IGS)
baseCommand:
- fastx_trimming
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
