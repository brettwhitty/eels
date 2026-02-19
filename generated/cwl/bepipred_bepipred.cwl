cwlVersion: v1.2
class: CommandLineTool
id: bepipred_bepipred
label: bepipred from bepipred component
doc: Tool execution from Ergatis bepipred component (TIGR/JCVI/IGS)
baseCommand:
- /local/projects/STREP/bepipred-1.0b/bepipred
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
