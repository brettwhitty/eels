cwlVersion: v1.2
class: CommandLineTool
id: tbl2asn_Move GenBank
label: Move GenBank from tbl2asn component
doc: Tool execution from Ergatis tbl2asn component (TIGR/JCVI/IGS)
baseCommand:
- '/bin/mv '
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
