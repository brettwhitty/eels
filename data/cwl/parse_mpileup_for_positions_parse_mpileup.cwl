cwlVersion: v1.2
class: CommandLineTool
id: parse_mpileup_for_positions_parse_mpileup
label: parse_mpileup from parse_mpileup_for_positions component
doc: Tool execution from Ergatis parse_mpileup_for_positions component (TIGR/JCVI/IGS)
baseCommand:
- parse_mpileup
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
