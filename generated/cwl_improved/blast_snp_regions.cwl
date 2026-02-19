cwlVersion: v1.2
class: CommandLineTool
id: blast_snp_regions
label: blast_snp_regions
doc: |
  none
  Classification: SNP
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [blast_snp_regions]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  expect:
    type: float?
    default: 0.0001
    doc: EXPECT parameter
  filter:
    type: string?
    default: "F"
    doc: FILTER parameter
  other_opts:
    type: string?
    default: "-m 0"
    doc: OTHER_OPTS parameter

outputs:
  raw_output:
    type: File
    outputBinding:
      glob: "*.txt"
    doc: raw format output
  parsed_output:
    type: File
    outputBinding:
      glob: "*.parsed"
    doc: parsed format output
