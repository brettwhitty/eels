cwlVersion: v1.2
class: CommandLineTool
id: phylip_dnadist_dnadist_worker_wrapper
label: dnadist_worker_wrapper from phylip_dnadist component
doc: Tool execution from Ergatis phylip_dnadist component (TIGR/JCVI/IGS)
baseCommand:
- dnadist_worker_wrapper
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
