cwlVersion: v1.2
class: CommandLineTool
id: blastn_plus_run blastn+
label: run blastn+ from blastn_plus component
doc: Tool execution from Ergatis blastn_plus component (TIGR/JCVI/IGS)
baseCommand:
- run blastn+
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
