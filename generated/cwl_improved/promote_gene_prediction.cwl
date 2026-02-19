cwlVersion: v1.2
class: CommandLineTool
id: promote_gene_prediction
label: promote_gene_prediction
doc: |
  none
  Classification: utility
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [promote_gene_prediction]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  cds_fasta:
    type: string?
    doc: CDS_FASTA parameter
  polypeptide_fasta:
    type: string?
    doc: POLYPEPTIDE_FASTA parameter
  project_abbreviation:
    type: string?
    default: "$;PROJECT$;"
    doc: PROJECT_ABBREVIATION parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
