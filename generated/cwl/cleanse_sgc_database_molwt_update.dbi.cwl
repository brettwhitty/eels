cwlVersion: v1.2
class: CommandLineTool
id: cleanse_sgc_database_molwt_update.dbi
label: molwt_update.dbi from cleanse_sgc_database component
doc: Tool execution from Ergatis cleanse_sgc_database component (TIGR/JCVI/IGS)
baseCommand:
- molwt_update.dbi
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
