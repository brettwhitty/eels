cwlVersion: v1.2
class: CommandLineTool
id: pangenome_make_graphs_prep the R input file
label: prep the R input file from pangenome_make_graphs component
doc: Tool execution from Ergatis pangenome_make_graphs component (TIGR/JCVI/IGS)
baseCommand:
- prep the R input file
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
