cwlVersion: v1.2
class: CommandLineTool
id: parse_for_ncRNAs_parse_for_ncRNAs
label: parse_for_ncRNAs from parse_for_ncRNAs component
doc: Tool execution from Ergatis parse_for_ncRNAs component (TIGR/JCVI/IGS)
baseCommand:
- parse_for_ncRNAs
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
