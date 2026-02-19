cwlVersion: v1.2
class: CommandLineTool
id: gff3_to_annotab_gff3_to_annotab
label: gff3_to_annotab from gff3_to_annotab component
doc: Tool execution from Ergatis gff3_to_annotab component (TIGR/JCVI/IGS)
baseCommand:
- gff3_to_annotab
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
