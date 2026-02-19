cwlVersion: v1.2
class: CommandLineTool
id: aat_na_masked_ext collapse
label: ext collapse from aat_na_masked component
doc: Tool execution from Ergatis aat_na_masked component (TIGR/JCVI/IGS)
baseCommand:
- ext collapse
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
