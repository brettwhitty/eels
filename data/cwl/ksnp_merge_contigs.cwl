cwlVersion: v1.2
class: CommandLineTool
id: ksnp_merge contigs
label: merge contigs from ksnp component
doc: Tool execution from Ergatis ksnp component (TIGR/JCVI/IGS)
baseCommand:
- merge contigs
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
