cwlVersion: v1.2
class: CommandLineTool
id: lgt_create_validated_bam_Create validated BAM
label: Create validated BAM from lgt_create_validated_bam component
doc: Tool execution from Ergatis lgt_create_validated_bam component (TIGR/JCVI/IGS)
baseCommand:
- Create validated BAM
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
