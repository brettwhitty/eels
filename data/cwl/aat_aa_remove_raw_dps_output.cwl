cwlVersion: v1.2
class: CommandLineTool
id: aat_aa_remove raw dps output
label: remove raw dps output from aat_aa component
doc: Tool execution from Ergatis aat_aa component (TIGR/JCVI/IGS)
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
