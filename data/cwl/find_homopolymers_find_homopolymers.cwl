cwlVersion: v1.2
class: CommandLineTool
id: find_homopolymers_find_homopolymers
label: find_homopolymers from find_homopolymers component
doc: Tool execution from Ergatis find_homopolymers component (TIGR/JCVI/IGS)
baseCommand:
- find_homopolymers
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
