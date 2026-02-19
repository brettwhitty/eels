cwlVersion: v1.2
class: CommandLineTool
id: cuffdiff
label: cuffdiff
doc: |
  generates cuffdiff analysis for the given annotation GTF file and sam filelist
  Classification: RNA-Seq
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [cuffdiff]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  label:
    type: string?
    doc: LABEL parameter
  num_threads:
    type: string?
    doc: NUM_THREADS parameter
  min_alignment_count:
    type: string?
    doc: MIN_ALIGNMENT_COUNT parameter
  fdr:
    type: string?
    doc: FDR parameter
  library_type:
    type: string?
    doc: LIBRARY_TYPE parameter
  max_mle_iterations:
    type: string?
    doc: MAX_MLE_ITERATIONS parameter
  min_isoform_fraction:
    type: string?
    doc: MIN_ISOFORM_FRACTION parameter
  max_bundle_frags:
    type: string?
    doc: MAX_BUNDLE_FRAGS parameter
  cufflinks_bin_dir:
    type: string?
    default: "$;CUFFDIFF_BIN$;"
    doc: CUFFLINKS_BIN_DIR parameter
  other_params:
    type: string?
    default: "-q"
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
