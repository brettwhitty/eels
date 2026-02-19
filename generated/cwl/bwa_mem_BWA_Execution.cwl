cwlVersion: v1.2
class: CommandLineTool
id: bwa_mem_BWA Execution
label: BWA Execution from bwa_mem component
doc: Tool execution from Ergatis bwa_mem component (TIGR/JCVI/IGS)
baseCommand:
- BWA Execution
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
