cwlVersion: v1.2
class: CommandLineTool
id: mothur_collect_single_collect single
label: collect single from mothur_collect_single component
doc: Tool execution from Ergatis mothur_collect_single component (TIGR/JCVI/IGS)
baseCommand:
- collect single
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
