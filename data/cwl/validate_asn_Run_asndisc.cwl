cwlVersion: v1.2
class: CommandLineTool
id: validate_asn_Run asndisc
label: Run asndisc from validate_asn component
doc: Tool execution from Ergatis validate_asn component (TIGR/JCVI/IGS)
baseCommand:
- /usr/local/bin/asndisc
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
