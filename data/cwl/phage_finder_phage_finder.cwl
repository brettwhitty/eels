cwlVersion: v1.2
class: CommandLineTool
id: phage_finder_phage finder
label: phage finder from phage_finder component
doc: Tool execution from Ergatis phage_finder component (TIGR/JCVI/IGS)
baseCommand:
- phage finder
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
