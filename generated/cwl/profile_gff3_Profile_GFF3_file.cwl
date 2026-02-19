cwlVersion: v1.2
class: CommandLineTool
id: profile_gff3_Profile GFF3 file
label: Profile GFF3 file from profile_gff3 component
doc: Tool execution from Ergatis profile_gff3 component (TIGR/JCVI/IGS)
baseCommand:
- Profile GFF3 file
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
