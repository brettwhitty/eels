cwlVersion: v1.2
class: CommandLineTool
id: phobos_phobos
label: phobos from phobos component
doc: Tool execution from Ergatis phobos component (TIGR/JCVI/IGS)
baseCommand:
- phobos
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
