cwlVersion: v1.2
class: CommandLineTool
id: filter_bogus_genes_filter_bogus_genes
label: filter_bogus_genes from filter_bogus_genes component
doc: Tool execution from Ergatis filter_bogus_genes component (TIGR/JCVI/IGS)
baseCommand:
- filter_bogus_genes
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
