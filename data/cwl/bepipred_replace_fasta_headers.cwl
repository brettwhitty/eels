cwlVersion: v1.2
class: CommandLineTool
id: bepipred_replace fasta headers
label: replace fasta headers from bepipred component
doc: Tool execution from Ergatis bepipred component (TIGR/JCVI/IGS)
baseCommand:
- replace fasta headers
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
