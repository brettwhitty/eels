cwlVersion: v1.2
class: CommandLineTool
id: sffinfo_sffinfo
label: sffinfo from sffinfo component
doc: Tool execution from Ergatis sffinfo component (TIGR/JCVI/IGS)
baseCommand:
- sffinfo
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
