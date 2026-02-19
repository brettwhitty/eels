cwlVersion: v1.2
class: CommandLineTool
id: aat_aa_masked_nap
label: nap from aat_aa_masked component
doc: Tool execution from Ergatis aat_aa_masked component (TIGR/JCVI/IGS)
baseCommand:
- nap
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
