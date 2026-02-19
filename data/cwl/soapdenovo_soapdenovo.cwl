cwlVersion: v1.2
class: CommandLineTool
id: soapdenovo_soapdenovo
label: soapdenovo from soapdenovo component
doc: Tool execution from Ergatis soapdenovo component (TIGR/JCVI/IGS)
baseCommand:
- soapdenovo
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
