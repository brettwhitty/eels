cwlVersion: v1.2
class: CommandLineTool
id: sra2fastq_create temp directory
label: create temp directory from sra2fastq component
doc: Tool execution from Ergatis sra2fastq component (TIGR/JCVI/IGS)
baseCommand:
- mkdir
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
