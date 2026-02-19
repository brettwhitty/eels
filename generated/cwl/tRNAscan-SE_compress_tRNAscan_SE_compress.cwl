cwlVersion: v1.2
class: CommandLineTool
id: tRNAscan-SE_compress_tRNAscan-SE_compress
label: tRNAscan-SE_compress from tRNAscan-SE_compress component
doc: Tool execution from Ergatis tRNAscan-SE_compress component (TIGR/JCVI/IGS)
baseCommand:
- tRNAscan-SE_compress
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
