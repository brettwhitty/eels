cwlVersion: v1.2
class: CommandLineTool
id: tophat
label: tophat
doc: |
  generates tophat alignment for the input sequence file(s) against the given reference index file.
  Classification: RNA-Seq
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [tophat]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  bowtie_bin_dir:
    type: string?
    default: "$;BOWTIE_BIN$;"
    doc: BOWTIE_BIN_DIR parameter
  samtools_bin_dir:
    type: string?
    default: "$;SAMTOOLS_BIN$;"
    doc: SAMTOOLS_BIN_DIR parameter
  tophat_bin_dir:
    type: string?
    default: "$;TOPHAT_BIN$;"
    doc: TOPHAT_BIN_DIR parameter
  mate_inner_dist:
    type: int?
    default: 200
    doc: MATE_INNER_DIST parameter
  mate_std_dev:
    type: int?
    default: 20
    doc: MATE_STD_DEV parameter
  min_anchor:
    type: int?
    default: 8
    doc: MIN_ANCHOR parameter
  splice_mismatches:
    type: string?
    doc: SPLICE_MISMATCHES parameter
  min_intron_length:
    type: int?
    default: 50
    doc: MIN_INTRON_LENGTH parameter
  max_intron_length:
    type: int?
    default: 500000
    doc: MAX_INTRON_LENGTH parameter
  max_insertion_length:
    type: int?
    default: 3
    doc: MAX_INSERTION_LENGTH parameter
  max_deletion_length:
    type: int?
    default: 3
    doc: MAX_DELETION_LENGTH parameter
  number_threads:
    type: int?
    default: 1
    doc: NUMBER_THREADS parameter
  max_multihits:
    type: int?
    default: 20
    doc: MAX_MULTIHITS parameter
  library_type:
    type: string?
    doc: LIBRARY_TYPE parameter
  bowtie_mode:
    type: string?
    default: "v"
    doc: BOWTIE_MODE parameter
  read_mismatches:
    type: int?
    default: 2
    doc: READ_MISMATCHES parameter
  segment_mismatches:
    type: int?
    default: 2
    doc: SEGMENT_MISMATCHES parameter
  segment_length:
    type: int?
    default: 25
    doc: SEGMENT_LENGTH parameter
  read_gap_length:
    type: string?
    doc: READ_GAP_LENGTH parameter
  read_edit_dist:
    type: string?
    doc: READ_EDIT_DIST parameter
  min_coverage_intron:
    type: int?
    default: 50
    doc: MIN_COVERAGE_INTRON parameter
  max_coverage_intron:
    type: int?
    default: 20000
    doc: MAX_COVERAGE_INTRON parameter
  min_segment_intron:
    type: int?
    default: 50
    doc: MIN_SEGMENT_INTRON parameter
  max_segment_intron:
    type: int?
    default: 500000
    doc: MAX_SEGMENT_INTRON parameter
  raw_juncs_file:
    type: string?
    doc: RAW_JUNCS_FILE parameter
  annotation_file:
    type: string?
    doc: ANNOTATION_FILE parameter
  transcriptome_index_prefix:
    type: string?
    doc: TRANSCRIPTOME_INDEX_PREFIX parameter
  ref_insertions_file:
    type: string?
    doc: REF_INSERTIONS_FILE parameter
  ref_deletions_file:
    type: string?
    doc: REF_DELETIONS_FILE parameter
  other_parameters:
    type: string?
    doc: OTHER_PARAMETERS parameter
  other_args:
    type: string?
    default: "--v"
    doc: OTHER_ARGS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
