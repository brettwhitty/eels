cwlVersion: v1.2
class: CommandLineTool
id: percent_gc_percent_gc
label: percent_gc from percent_gc component
doc: Tool execution from Ergatis percent_gc component (TIGR/JCVI/IGS)
baseCommand:
- percent_gc
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
