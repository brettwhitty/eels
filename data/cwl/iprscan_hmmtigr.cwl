cwlVersion: v1.2
class: CommandLineTool
id: iprscan_hmmtigr
label: hmmtigr from iprscan component
doc: Tool execution from Ergatis iprscan component (TIGR/JCVI/IGS)
baseCommand:
- hmmtigr
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
