cwlVersion: v1.2
class: CommandLineTool
id: promote_gene_prediction_promote gene prediction
label: promote gene prediction from promote_gene_prediction component
doc: Tool execution from Ergatis promote_gene_prediction component (TIGR/JCVI/IGS)
baseCommand:
- promote gene prediction
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
