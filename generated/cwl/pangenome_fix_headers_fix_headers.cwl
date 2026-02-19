cwlVersion: v1.2
class: CommandLineTool
id: pangenome_fix_headers_fix headers
label: fix headers from pangenome_fix_headers component
doc: Tool execution from Ergatis pangenome_fix_headers component (TIGR/JCVI/IGS)
baseCommand:
- fix headers
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
