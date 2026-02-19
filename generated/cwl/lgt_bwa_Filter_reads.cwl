cwlVersion: v1.2
class: CommandLineTool
id: lgt_bwa_Filter reads
label: Filter reads from lgt_bwa component
doc: Tool execution from Ergatis lgt_bwa component (TIGR/JCVI/IGS)
baseCommand:
- Filter reads
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
