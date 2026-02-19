cwlVersion: v1.2
class: CommandLineTool
id: genemark_migrate output file
label: migrate output file from genemark component
doc: Tool execution from Ergatis genemark component (TIGR/JCVI/IGS)
baseCommand:
- mv
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
