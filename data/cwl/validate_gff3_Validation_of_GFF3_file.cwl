cwlVersion: v1.2
class: CommandLineTool
id: validate_gff3_Validation of GFF3 file
label: Validation of GFF3 file from validate_gff3 component
doc: Tool execution from Ergatis validate_gff3 component (TIGR/JCVI/IGS)
baseCommand:
- Validation of GFF3 file
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
