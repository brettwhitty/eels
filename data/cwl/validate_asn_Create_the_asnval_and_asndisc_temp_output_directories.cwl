cwlVersion: v1.2
class: CommandLineTool
id: validate_asn_Create the asnval and asndisc temp output directories
label: Create the asnval and asndisc temp output directories from validate_asn component
doc: Tool execution from Ergatis validate_asn component (TIGR/JCVI/IGS)
baseCommand:
- mkdir
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
