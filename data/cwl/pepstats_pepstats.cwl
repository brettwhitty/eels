cwlVersion: v1.2
class: CommandLineTool
id: pepstats_pepstats
label: pepstats from pepstats component
doc: Tool execution from Ergatis pepstats component (TIGR/JCVI/IGS)
baseCommand:
- pepstats
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
