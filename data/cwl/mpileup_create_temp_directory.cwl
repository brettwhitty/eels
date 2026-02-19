cwlVersion: v1.2
class: CommandLineTool
id: mpileup_create temp directory
label: create temp directory from mpileup component
doc: Tool execution from Ergatis mpileup component (TIGR/JCVI/IGS)
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
