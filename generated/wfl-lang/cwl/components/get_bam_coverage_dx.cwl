cwlVersion: v1.2
class: CommandLineTool
id: get_bam_coverage_dx
label: get_bam_coverage_dx
doc: |
  none
  Classification: alignment
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [mkdir]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  min_coverage:
    type: int?
    default: 10
    doc: MIN_COVERAGE parameter

outputs:
  avg_cov_output:
    type: File
    outputBinding:
      glob: "*.avg_cov"
    doc: avg_cov format output
  breadth_output:
    type: File
    outputBinding:
      glob: "*.breadth"
    doc: breadth format output
