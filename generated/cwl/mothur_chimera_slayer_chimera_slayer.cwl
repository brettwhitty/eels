cwlVersion: v1.2
class: CommandLineTool
id: mothur_chimera_slayer_chimera slayer
label: chimera slayer from mothur_chimera_slayer component
doc: Tool execution from Ergatis mothur_chimera_slayer component (TIGR/JCVI/IGS)
baseCommand:
- chimera slayer
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
