cwlVersion: v1.2
class: CommandLineTool
id: blastp_plus_run blastp+
label: run blastp+ from blastp_plus component
doc: Tool execution from Ergatis blastp_plus component (TIGR/JCVI/IGS)
baseCommand:
- run blastp+
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
