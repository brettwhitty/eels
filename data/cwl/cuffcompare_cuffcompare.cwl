cwlVersion: v1.2
class: CommandLineTool
id: cuffcompare_cuffcompare
label: cuffcompare from cuffcompare component
doc: Tool execution from Ergatis cuffcompare component (TIGR/JCVI/IGS)
baseCommand:
- cuffcompare
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
