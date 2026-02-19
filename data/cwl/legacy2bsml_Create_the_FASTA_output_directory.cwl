cwlVersion: v1.2
class: CommandLineTool
id: legacy2bsml_Create the FASTA output directory
label: Create the FASTA output directory from legacy2bsml component
doc: Tool execution from Ergatis legacy2bsml component (TIGR/JCVI/IGS)
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
