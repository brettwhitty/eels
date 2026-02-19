cwlVersion: v1.2
class: CommandLineTool
id: leech_leech plotting
label: leech plotting from leech component
doc: Tool execution from Ergatis leech component (TIGR/JCVI/IGS)
baseCommand:
- /opt/leech/leech
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
