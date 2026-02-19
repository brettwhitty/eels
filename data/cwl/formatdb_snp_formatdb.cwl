cwlVersion: v1.2
class: CommandLineTool
id: formatdb_snp_formatdb
label: formatdb from formatdb_snp component
doc: Tool execution from Ergatis formatdb_snp component (TIGR/JCVI/IGS)
baseCommand:
- formatdb
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
