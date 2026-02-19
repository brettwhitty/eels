cwlVersion: v1.2
class: CommandLineTool
id: usearch_usearch
label: usearch from usearch component
doc: Tool execution from Ergatis usearch component (TIGR/JCVI/IGS)
baseCommand:
- usearch
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
