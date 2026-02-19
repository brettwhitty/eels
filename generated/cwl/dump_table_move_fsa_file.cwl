cwlVersion: v1.2
class: CommandLineTool
id: dump_table_move fsa file
label: move fsa file from dump_table component
doc: Tool execution from Ergatis dump_table component (TIGR/JCVI/IGS)
baseCommand:
- /bin/mv
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
