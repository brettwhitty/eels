cwlVersion: v1.2
class: CommandLineTool
id: ksnp
label: ksnp
doc: |
  none
  Classification: SNP
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [ksnp_merge_reference]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  kmer:
    type: string?
    doc: Kmer parameter
  reference_genbank:
    type: string?
    doc: REFERENCE_GENBANK parameter

outputs:
  raw_output:
    type: File
    outputBinding:
      glob: "*.txt"
    doc: raw format output
