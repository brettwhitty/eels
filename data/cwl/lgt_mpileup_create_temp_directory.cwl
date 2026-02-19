cwlVersion: v1.2
class: CommandLineTool
id: lgt_mpileup_create temp directory
label: create temp directory from lgt_mpileup component
doc: Tool execution from Ergatis lgt_mpileup component (TIGR/JCVI/IGS)
baseCommand:
- mkdir
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
