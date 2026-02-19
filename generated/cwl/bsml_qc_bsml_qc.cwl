cwlVersion: v1.2
class: CommandLineTool
id: bsml_qc_bsml_qc
label: bsml_qc from bsml_qc component
doc: Tool execution from Ergatis bsml_qc component (TIGR/JCVI/IGS)
baseCommand:
- bsml_qc
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
