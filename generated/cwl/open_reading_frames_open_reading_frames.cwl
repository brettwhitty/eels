cwlVersion: v1.2
class: CommandLineTool
id: open_reading_frames_open_reading_frames
label: open_reading_frames from open_reading_frames component
doc: Tool execution from Ergatis open_reading_frames component (TIGR/JCVI/IGS)
baseCommand:
- open_reading_frames
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
