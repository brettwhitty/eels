cwlVersion: v1.2
class: CommandLineTool
id: antigenic_antigenic
label: antigenic from antigenic component
doc: Tool execution from Ergatis antigenic component (TIGR/JCVI/IGS)
baseCommand:
- /usr/local/packages/EMBOSS/bin/antigenic
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
