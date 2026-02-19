cwlVersion: v1.2
class: CommandLineTool
id: wu-blastp_wu-blastp
label: wu-blastp from wu-blastp component
doc: Tool execution from Ergatis wu-blastp component (TIGR/JCVI/IGS)
baseCommand:
- wu-blastp
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
