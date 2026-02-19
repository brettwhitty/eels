cwlVersion: v1.2
class: CommandLineTool
id: samtools_file_convert_samtools_file_convert
label: samtools_file_convert from samtools_file_convert component
doc: Tool execution from Ergatis samtools_file_convert component (TIGR/JCVI/IGS)
baseCommand:
- samtools_file_convert
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
