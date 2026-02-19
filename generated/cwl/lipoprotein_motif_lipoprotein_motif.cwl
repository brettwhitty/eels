cwlVersion: v1.2
class: CommandLineTool
id: lipoprotein_motif_lipoprotein_motif
label: lipoprotein_motif from lipoprotein_motif component
doc: Tool execution from Ergatis lipoprotein_motif component (TIGR/JCVI/IGS)
baseCommand:
- lipoprotein_motif
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
