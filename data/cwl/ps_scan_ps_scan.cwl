cwlVersion: v1.2
class: CommandLineTool
id: ps_scan_ps_scan
label: ps_scan from ps_scan component
doc: Tool execution from Ergatis ps_scan component (TIGR/JCVI/IGS)
baseCommand:
- ps_scan
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
