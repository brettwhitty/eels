cwlVersion: v1.2
class: CommandLineTool
id: mothur_read_otu_read otu
label: read otu from mothur_read_otu component
doc: Tool execution from Ergatis mothur_read_otu component (TIGR/JCVI/IGS)
baseCommand:
- read otu
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
