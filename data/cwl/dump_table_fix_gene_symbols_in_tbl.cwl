cwlVersion: v1.2
class: CommandLineTool
id: dump_table_fix gene symbols in tbl
label: fix gene symbols in tbl from dump_table component
doc: Tool execution from Ergatis dump_table component (TIGR/JCVI/IGS)
baseCommand:
- fix gene symbols in tbl
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
