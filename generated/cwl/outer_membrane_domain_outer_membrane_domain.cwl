cwlVersion: v1.2
class: CommandLineTool
id: outer_membrane_domain_outer_membrane_domain
label: outer_membrane_domain from outer_membrane_domain component
doc: Tool execution from Ergatis outer_membrane_domain component (TIGR/JCVI/IGS)
baseCommand:
- outer_membrane_domain
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
