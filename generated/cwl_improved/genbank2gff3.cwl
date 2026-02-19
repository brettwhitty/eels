cwlVersion: v1.2
class: CommandLineTool
id: genbank2gff3
label: genbank2gff3
doc: |
  aligns reads against a single reference file contining one or more contigs
  Classification: RNA-Seq
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [UNKNOWN]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  genbank_file:
    type: string?
    default: "/local/projects/ifx_core/rna_seq/tcreasy/rna_seq/output_repository/bowtie/37_default/NC_000117.1.gb"
    doc: GENBANK_FILE parameter
  gff3_file:
    type: string?
    default: "/local/projects/ifx_core/rna_seq/tcreasy/rna_seq/output_repository/bowtie/37_default/NC_000117.1.rRNA.gff3"
    doc: GFF3_FILE parameter
  feat_type:
    type: string?
    default: "CDS"
    doc: FEAT_TYPE parameter
  other_args:
    type: string?
    doc: OTHER_ARGS parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
