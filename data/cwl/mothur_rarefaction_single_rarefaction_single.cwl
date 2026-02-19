cwlVersion: v1.2
class: CommandLineTool
id: mothur_rarefaction_single_rarefaction single
label: rarefaction single from mothur_rarefaction_single component
doc: Tool execution from Ergatis mothur_rarefaction_single component (TIGR/JCVI/IGS)
baseCommand:
- rarefaction single
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
