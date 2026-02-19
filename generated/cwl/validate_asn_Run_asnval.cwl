cwlVersion: v1.2
class: CommandLineTool
id: validate_asn_Run asnval
label: Run asnval from validate_asn component
doc: Tool execution from Ergatis validate_asn component (TIGR/JCVI/IGS)
baseCommand:
- /usr/local/bin/asnval
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
