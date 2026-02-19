cwlVersion: v1.2
class: CommandLineTool
id: curate_common_names_curate common names
label: curate common names from curate_common_names component
doc: Tool execution from Ergatis curate_common_names component (TIGR/JCVI/IGS)
baseCommand:
- curate common names
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
