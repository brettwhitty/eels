cwlVersion: v1.2
class: CommandLineTool
id: signalp_Rename signalp graphics files
label: Rename signalp graphics files from signalp component
doc: Tool execution from Ergatis signalp component (TIGR/JCVI/IGS)
baseCommand:
- Rename signalp graphics files
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
