cwlVersion: v1.2
class: CommandLineTool
id: wu-blastn_wu-blastn
label: wu-blastn from wu-blastn component
doc: Tool execution from Ergatis wu-blastn component (TIGR/JCVI/IGS)
baseCommand:
- /usr/local/bin/blastn
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
