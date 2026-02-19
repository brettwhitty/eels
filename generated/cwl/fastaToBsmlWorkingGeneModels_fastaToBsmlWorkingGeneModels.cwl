cwlVersion: v1.2
class: CommandLineTool
id: fastaToBsmlWorkingGeneModels_fastaToBsmlWorkingGeneModels
label: fastaToBsmlWorkingGeneModels from fastaToBsmlWorkingGeneModels component
doc: Tool execution from Ergatis fastaToBsmlWorkingGeneModels component (TIGR/JCVI/IGS)
baseCommand:
- fastaToBsmlWorkingGeneModels
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
