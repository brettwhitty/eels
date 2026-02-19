cwlVersion: v1.2
class: CommandLineTool
id: cleanse_sgc_database_sgc_GC_content_load.spl
label: sgc_GC_content_load.spl from cleanse_sgc_database component
doc: Tool execution from Ergatis cleanse_sgc_database component (TIGR/JCVI/IGS)
baseCommand:
- sgc_GC_content_load.spl
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
