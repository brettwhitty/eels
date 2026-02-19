cwlVersion: v1.2
class: CommandLineTool
id: gkpstore2fastq_cat files
label: cat files from gkpstore2fastq component
doc: Tool execution from Ergatis gkpstore2fastq component (TIGR/JCVI/IGS)
baseCommand:
- /bin/cat
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
