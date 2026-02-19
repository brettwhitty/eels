cwlVersion: v1.2
class: CommandLineTool
id: fastaToBsmlWorkingGeneModels_profileBSMLFile
label: profileBSMLFile from fastaToBsmlWorkingGeneModels component
doc: Tool execution from Ergatis fastaToBsmlWorkingGeneModels component (TIGR/JCVI/IGS)
baseCommand:
- profileBSMLFile
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
