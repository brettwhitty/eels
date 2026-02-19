cwlVersion: v1.2
class: CommandLineTool
id: priam_ec_assignment_priam_ec_assignment
label: priam_ec_assignment from priam_ec_assignment component
doc: Tool execution from Ergatis priam_ec_assignment component (TIGR/JCVI/IGS)
baseCommand:
- priam_ec_assignment
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
