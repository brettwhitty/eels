cwlVersion: v1.2
class: CommandLineTool
id: pangenome_blast_parse_parse blast results
label: parse blast results from pangenome_blast_parse component
doc: Tool execution from Ergatis pangenome_blast_parse component (TIGR/JCVI/IGS)
baseCommand:
- parse blast results
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
