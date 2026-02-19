cwlVersion: v1.2
class: CommandLineTool
id: dump_table_dump table
label: dump table from dump_table component
doc: Tool execution from Ergatis dump_table component (TIGR/JCVI/IGS)
baseCommand:
- dump table
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
