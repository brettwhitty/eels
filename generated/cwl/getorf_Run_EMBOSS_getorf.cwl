cwlVersion: v1.2
class: CommandLineTool
id: getorf_Run EMBOSS getorf
label: Run EMBOSS getorf from getorf component
doc: Tool execution from Ergatis getorf component (TIGR/JCVI/IGS)
baseCommand:
- Run EMBOSS getorf
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
