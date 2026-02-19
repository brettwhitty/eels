cwlVersion: v1.2
class: CommandLineTool
id: bowtie_bowtie
label: bowtie from bowtie component
doc: Tool execution from Ergatis bowtie component (TIGR/JCVI/IGS)
baseCommand:
- bowtie
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
