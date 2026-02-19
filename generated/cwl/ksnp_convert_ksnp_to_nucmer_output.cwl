cwlVersion: v1.2
class: CommandLineTool
id: ksnp_convert ksnp to nucmer output
label: convert ksnp to nucmer output from ksnp component
doc: Tool execution from Ergatis ksnp component (TIGR/JCVI/IGS)
baseCommand:
- convert ksnp to nucmer output
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
