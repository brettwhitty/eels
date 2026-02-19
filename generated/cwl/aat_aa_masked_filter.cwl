cwlVersion: v1.2
class: CommandLineTool
id: aat_aa_masked_filter
label: filter from aat_aa_masked component
doc: Tool execution from Ergatis aat_aa_masked component (TIGR/JCVI/IGS)
baseCommand:
- filter
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
