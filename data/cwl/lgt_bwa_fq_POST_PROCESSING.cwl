cwlVersion: v1.2
class: CommandLineTool
id: lgt_bwa_fq_POST PROCESSING
label: POST PROCESSING from lgt_bwa_fq component
doc: Tool execution from Ergatis lgt_bwa_fq component (TIGR/JCVI/IGS)
baseCommand:
- POST PROCESSING
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
