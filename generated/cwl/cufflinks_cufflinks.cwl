cwlVersion: v1.2
class: CommandLineTool
id: cufflinks_cufflinks
label: cufflinks from cufflinks component
doc: Tool execution from Ergatis cufflinks component (TIGR/JCVI/IGS)
baseCommand:
- cufflinks
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
