cwlVersion: v1.2
class: CommandLineTool
id: metagenemark_metagenemark
label: metagenemark from metagenemark component
doc: Tool execution from Ergatis metagenemark component (TIGR/JCVI/IGS)
baseCommand:
- metagenemark
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
