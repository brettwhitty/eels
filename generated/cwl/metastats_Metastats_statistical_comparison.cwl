cwlVersion: v1.2
class: CommandLineTool
id: metastats_Metastats statistical comparison
label: Metastats statistical comparison from metastats component
doc: Tool execution from Ergatis metastats component (TIGR/JCVI/IGS)
baseCommand:
- Metastats statistical comparison
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
