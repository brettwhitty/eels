cwlVersion: v1.2
class: CommandLineTool
id: samtools_reference_index_samtools_reference_index
label: samtools_reference_index from samtools_reference_index component
doc: Tool execution from Ergatis samtools_reference_index component (TIGR/JCVI/IGS)
baseCommand:
- samtools_reference_index
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
