cwlVersion: v1.2
class: CommandLineTool
id: nucmer-delta-filter_delta-filter
label: delta-filter from nucmer-delta-filter component
doc: Tool execution from Ergatis nucmer-delta-filter component (TIGR/JCVI/IGS)
baseCommand:
- delta-filter
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
