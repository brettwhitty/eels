cwlVersion: v1.2
class: CommandLineTool
id: lgt_mpileup_mpileup Execution
label: mpileup Execution from lgt_mpileup component
doc: Tool execution from Ergatis lgt_mpileup component (TIGR/JCVI/IGS)
baseCommand:
- mpileup Execution
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
