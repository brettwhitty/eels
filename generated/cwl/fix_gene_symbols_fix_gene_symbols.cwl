cwlVersion: v1.2
class: CommandLineTool
id: fix_gene_symbols_fix gene symbols
label: fix gene symbols from fix_gene_symbols component
doc: Tool execution from Ergatis fix_gene_symbols component (TIGR/JCVI/IGS)
baseCommand:
- fix gene symbols
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
