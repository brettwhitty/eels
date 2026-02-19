cwlVersion: v1.2
class: CommandLineTool
id: rdp_classifier_RDP classifier
label: RDP classifier from rdp_classifier component
doc: Tool execution from Ergatis rdp_classifier component (TIGR/JCVI/IGS)
baseCommand:
- RDP classifier
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
