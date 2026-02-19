cwlVersion: v1.2
class: CommandLineTool
id: update_ec_numbers_update ec numbers
label: update ec numbers from update_ec_numbers component
doc: Tool execution from Ergatis update_ec_numbers component (TIGR/JCVI/IGS)
baseCommand:
- update ec numbers
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
