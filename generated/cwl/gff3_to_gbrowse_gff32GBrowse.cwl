cwlVersion: v1.2
class: CommandLineTool
id: gff3_to_gbrowse_gff32GBrowse
label: gff32GBrowse from gff3_to_gbrowse component
doc: Tool execution from Ergatis gff3_to_gbrowse component (TIGR/JCVI/IGS)
baseCommand:
- gff32GBrowse
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
