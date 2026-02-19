cwlVersion: v1.2
class: CommandLineTool
id: sfffile_sfffile
label: sfffile from sfffile component
doc: Tool execution from Ergatis sfffile component (TIGR/JCVI/IGS)
baseCommand:
- sfffile
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
