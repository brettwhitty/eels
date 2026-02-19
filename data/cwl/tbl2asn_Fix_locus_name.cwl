cwlVersion: v1.2
class: CommandLineTool
id: tbl2asn_Fix locus name
label: Fix locus name from tbl2asn component
doc: Tool execution from Ergatis tbl2asn component (TIGR/JCVI/IGS)
baseCommand:
- perl
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
