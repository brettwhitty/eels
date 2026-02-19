cwlVersion: v1.2
class: CommandLineTool
id: bowtie_build_bowtie_build
label: bowtie_build from bowtie_build component
doc: Tool execution from Ergatis bowtie_build component (TIGR/JCVI/IGS)
baseCommand:
- bowtie_build
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
