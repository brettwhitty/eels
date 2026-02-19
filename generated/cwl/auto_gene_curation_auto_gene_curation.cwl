cwlVersion: v1.2
class: CommandLineTool
id: auto_gene_curation_auto gene curation
label: auto gene curation from auto_gene_curation component
doc: Tool execution from Ergatis auto_gene_curation component (TIGR/JCVI/IGS)
baseCommand:
- auto gene curation
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
