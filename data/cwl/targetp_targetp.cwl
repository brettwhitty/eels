cwlVersion: v1.2
class: CommandLineTool
id: targetp_targetp
label: targetp from targetp component
doc: Tool execution from Ergatis targetp component (TIGR/JCVI/IGS)
baseCommand:
- targetp
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
