cwlVersion: v1.2
class: CommandLineTool
id: cufflinks
label: cufflinks
doc: |
  generates cufflinks isoform identification analysis for the given SAM or BAM alignment file
  Classification: RNA-Seq
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [cufflinks]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  annotation_file:
    type: string?
    doc: ANNOTATION_FILE parameter
  library_type:
    type: string?
    doc: LIBRARY_TYPE parameter
  frag_len_mean:
    type: string?
    doc: FRAG_LEN_MEAN parameter
  frag_len_std_dev:
    type: string?
    doc: FRAG_LEN_STD_DEV parameter
  max_mle_iterations:
    type: string?
    doc: MAX_MLE_ITERATIONS parameter
  max_bundle_frags:
    type: string?
    doc: MAX_BUNDLE_FRAGS parameter
  label:
    type: string?
    default: "CUFF"
    doc: LABEL parameter
  min_isoform_fraction:
    type: string?
    doc: MIN_ISOFORM_FRACTION parameter
  pre_mrna_fraction:
    type: string?
    doc: PRE_mRNA_FRACTION parameter
  min_intron_len:
    type: string?
    doc: MIN_INTRON_LEN parameter
  max_intron_len:
    type: string?
    doc: MAX_INTRON_LEN parameter
  junc_alpha:
    type: string?
    doc: JUNC_ALPHA parameter
  small_anchor_fraction:
    type: string?
    doc: SMALL_ANCHOR_FRACTION parameter
  min_frags_per_transfrag:
    type: string?
    doc: MIN_FRAGS_PER_TRANSFRAG parameter
  overhang_tolerance:
    type: string?
    doc: OVERHANG_TOLERANCE parameter
  max_bundle_length:
    type: string?
    doc: MAX_BUNDLE_LENGTH parameter
  trim3_avgcov_thresh:
    type: string?
    doc: TRIM3_AVGCOV_THRESH parameter
  trim3_dropoff_frac:
    type: string?
    doc: TRIM3_DROPOFF_FRAC parameter
  num_threads:
    type: string?
    doc: NUM_THREADS parameter
  cufflinks_bin_dir:
    type: string?
    default: "$;CUFFLINKS_BIN$;"
    doc: CUFFLINKS_BIN_DIR parameter
  other_params:
    type: string?
    default: "--quiet"
    doc: OTHER_PARAMS parameter
  other_args:
    type: string?
    default: "--v"
    doc: OTHER_ARGS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
