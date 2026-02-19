cwlVersion: v1.2
class: CommandLineTool
id: cleanse_sgc_database_rewrite_seqs.dbi
label: rewrite_seqs.dbi from cleanse_sgc_database component
doc: Tool execution from Ergatis cleanse_sgc_database component (TIGR/JCVI/IGS)
baseCommand:
- rewrite_seqs.dbi
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
