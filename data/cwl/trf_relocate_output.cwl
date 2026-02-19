cwlVersion: v1.2
class: CommandLineTool
id: trf_relocate output
label: relocate output from trf component
doc: Tool execution from Ergatis trf component (TIGR/JCVI/IGS)
baseCommand:
- find
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
