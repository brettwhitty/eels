cwlVersion: v1.2
class: CommandLineTool
id: aat_na_masked_remove raw dds output
label: remove raw dds output from aat_na_masked component
doc: Tool execution from Ergatis aat_na_masked component (TIGR/JCVI/IGS)
baseCommand:
- rm
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
