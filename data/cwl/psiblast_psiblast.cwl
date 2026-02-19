cwlVersion: v1.2
class: CommandLineTool
id: psiblast_psiblast
label: psiblast from psiblast component
doc: Tool execution from Ergatis psiblast component (TIGR/JCVI/IGS)
baseCommand:
- psiblast
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
