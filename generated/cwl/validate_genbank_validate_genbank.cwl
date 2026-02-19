cwlVersion: v1.2
class: CommandLineTool
id: validate_genbank_validate_genbank
label: validate_genbank from validate_genbank component
doc: Tool execution from Ergatis validate_genbank component (TIGR/JCVI/IGS)
baseCommand:
- validate_genbank
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
