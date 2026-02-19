cwlVersion: v1.2
class: CommandLineTool
id: condor_cogs_search_condor_cog_search.dbi
label: condor_cog_search.dbi from condor_cogs_search component
doc: Tool execution from Ergatis condor_cogs_search component (TIGR/JCVI/IGS)
baseCommand:
- condor_cog_search.dbi
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
