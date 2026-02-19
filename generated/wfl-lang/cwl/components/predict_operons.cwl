cwlVersion: v1.2
class: CommandLineTool
id: predict_operons
label: predict_operons
doc: |
  none
  Classification: feature prediction / genes
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [predict_operons]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  reference_fasta:
    type: string?
    doc: REFERENCE_FASTA parameter
  gff_file:
    type: string?
    doc: GFF_FILE parameter
  abbr:
    type: string?
    doc: ABBR parameter

outputs:
  gff3_output:
    type: File
    outputBinding:
      glob: "*.gff3"
    doc: gff3 format output
