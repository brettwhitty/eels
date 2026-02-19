cwlVersion: v1.2
class: CommandLineTool
id: signalp_Run signalp
label: Run signalp from signalp component
doc: Tool execution from Ergatis signalp component (TIGR/JCVI/IGS)
baseCommand:
- Run signalp
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
