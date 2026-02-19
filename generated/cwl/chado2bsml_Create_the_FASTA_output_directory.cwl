cwlVersion: v1.2
class: CommandLineTool
id: chado2bsml_Create the FASTA output directory
label: Create the FASTA output directory from chado2bsml component
doc: Tool execution from Ergatis chado2bsml component (TIGR/JCVI/IGS)
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
