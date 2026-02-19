cwlVersion: v1.2
class: CommandLineTool
id: filter_sequences_by_id_filter
label: filter from filter_sequences_by_id component
doc: Tool execution from Ergatis filter_sequences_by_id component (TIGR/JCVI/IGS)
baseCommand:
- filter
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
