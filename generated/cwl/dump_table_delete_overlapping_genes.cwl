cwlVersion: v1.2
class: CommandLineTool
id: dump_table_delete overlapping genes
label: delete overlapping genes from dump_table component
doc: Tool execution from Ergatis dump_table component (TIGR/JCVI/IGS)
baseCommand:
- delete overlapping genes
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
