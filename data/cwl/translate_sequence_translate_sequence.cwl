cwlVersion: v1.2
class: CommandLineTool
id: translate_sequence_translate_sequence
label: translate_sequence from translate_sequence component
doc: Tool execution from Ergatis translate_sequence component (TIGR/JCVI/IGS)
baseCommand:
- translate_sequence
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
