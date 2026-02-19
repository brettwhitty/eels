cwlVersion: v1.2
class: CommandLineTool
id: bam_merge_bam_merge
label: bam_merge from bam_merge component
doc: Tool execution from Ergatis bam_merge component (TIGR/JCVI/IGS)
baseCommand:
- bam_merge
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
