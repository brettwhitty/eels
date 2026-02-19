cwlVersion: v1.2
class: CommandLineTool
id: blast_lgt_finder_Filter BLAST for best hits
label: Filter BLAST for best hits from blast_lgt_finder component
doc: Tool execution from Ergatis blast_lgt_finder component (TIGR/JCVI/IGS)
baseCommand:
- Filter BLAST for best hits
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
