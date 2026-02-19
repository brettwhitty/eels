cwlVersion: v1.2
class: CommandLineTool
id: condor_cogs_search_Create database output directory
label: Create database output directory from condor_cogs_search component
doc: Tool execution from Ergatis condor_cogs_search component (TIGR/JCVI/IGS)
baseCommand:
- mkdir
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
