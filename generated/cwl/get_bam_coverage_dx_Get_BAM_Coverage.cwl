cwlVersion: v1.2
class: CommandLineTool
id: get_bam_coverage_dx_Get BAM Coverage
label: Get BAM Coverage from get_bam_coverage_dx component
doc: Tool execution from Ergatis get_bam_coverage_dx component (TIGR/JCVI/IGS)
baseCommand:
- Get BAM Coverage
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
