cwlVersion: v1.2
class: CommandLineTool
id: fastaToBsmlWorkingGeneModels_Create the FASTA output directory
label: Create the FASTA output directory from fastaToBsmlWorkingGeneModels component
doc: Tool execution from Ergatis fastaToBsmlWorkingGeneModels component (TIGR/JCVI/IGS)
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
