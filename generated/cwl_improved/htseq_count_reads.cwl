cwlVersion: v1.2
class: CommandLineTool
id: htseq_count_reads
label: htseq_count_reads
doc: |
  uses the HTseq Python package to count reads aligning to features
  Classification: alignment
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [htseq_count_reads.sh]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  gtf_file:
    type: string?
    doc: GTF_FILE parameter
  count_mode:
    type: string?
    default: "union"
    doc: COUNT_MODE parameter
  counting_feature:
    type: string?
    default: "exon"
    doc: COUNTING_FEATURE parameter
  min_align_qual:
    type: string?
    doc: MIN_ALIGN_QUAL parameter
  is_stranded:
    type: string?
    default: "no"
    doc: IS_STRANDED parameter
  id_attribute:
    type: string?
    default: "gene_id"
    doc: ID_ATTRIBUTE parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
