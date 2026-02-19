cwlVersion: v1.2
class: CommandLineTool
id: solsnp
label: solsnp
doc: |
  none
  Classification: SNP
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [java -jar ]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  ref_sequence:
    type: string?
    doc: REF_SEQUENCE parameter
  filter:
    type: string?
    doc: FILTER parameter
  min_coverage:
    type: string?
    doc: MIN_COVERAGE parameter
  min_base_quality:
    type: string?
    doc: MIN_BASE_QUALITY parameter

outputs:
  vcf_output:
    type: File
    outputBinding:
      glob: "*.vcf"
    doc: vcf format output
