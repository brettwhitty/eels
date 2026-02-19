cwlVersion: v1.2
class: CommandLineTool
id: bam2coverage
label: bam2coverage
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
  bam_file:
    type: string?
    default: "/local/projects/ifx_core/rna_seq/tcreasy/rna_seq/output_repository/bowtie/37_default/test.sorted.bam"
    doc: BAM_FILE parameter
  stranded:
    type: string?
    doc: STRANDED parameter
  gff3_file:
    type: string?
    default: "/local/projects/ifx_core/rna_seq/tcreasy/rna_seq/output_repository/bowtie/37_default/gasalab49.gff"
    doc: GFF3_FILE parameter
  feature_type:
    type: string?
    default: "CDS"
    doc: FEATURE_TYPE parameter
  genome_only:
    type: string?
    doc: GENOME_ONLY parameter
  features_only:
    type: string?
    doc: FEATURES_ONLY parameter
  total_mapped_reads:
    type: string?
    doc: TOTAL_MAPPED_READS parameter
  other_args:
    type: string?
    doc: OTHER_ARGS parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
