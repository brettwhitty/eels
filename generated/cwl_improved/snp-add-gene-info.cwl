cwlVersion: v1.2
class: CommandLineTool
id: snp-add-gene-info
label: snp-add-gene-info
doc: |
  none
  Classification: SNP
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
  reference_genbank:
    type: string?
    doc: REFERENCE_GENBANK parameter
  query_fasta_list:
    type: string?
    doc: QUERY_FASTA_LIST parameter

outputs:
  raw_output:
    type: File
    outputBinding:
      glob: "*.txt"
    doc: raw format output
