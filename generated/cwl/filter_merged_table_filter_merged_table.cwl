cwlVersion: v1.2
class: CommandLineTool
id: filter_merged_table_filter_merged_table
label: filter_merged_table from filter_merged_table component
doc: Tool execution from Ergatis filter_merged_table component (TIGR/JCVI/IGS)
baseCommand:
- filter_merged_table
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
