cwlVersion: v1.2
class: CommandLineTool
id: signalp_Create scratch dir for signalp output
label: Create scratch dir for signalp output from signalp component
doc: Tool execution from Ergatis signalp component (TIGR/JCVI/IGS)
baseCommand:
- mkdir
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
