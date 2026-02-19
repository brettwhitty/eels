cwlVersion: v1.2
class: CommandLineTool
id: dump_table_create sbt and cmt files
label: create sbt and cmt files from dump_table component
doc: Tool execution from Ergatis dump_table component (TIGR/JCVI/IGS)
baseCommand:
- create sbt and cmt files
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
