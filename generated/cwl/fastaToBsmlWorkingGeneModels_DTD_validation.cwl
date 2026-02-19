cwlVersion: v1.2
class: CommandLineTool
id: fastaToBsmlWorkingGeneModels_DTD validation
label: DTD validation from fastaToBsmlWorkingGeneModels component
doc: Tool execution from Ergatis fastaToBsmlWorkingGeneModels component (TIGR/JCVI/IGS)
baseCommand:
- DTD validation
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
