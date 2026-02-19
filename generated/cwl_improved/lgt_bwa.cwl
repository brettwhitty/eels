cwlVersion: v1.2
class: CommandLineTool
id: lgt_bwa
label: lgt_bwa
doc: |
  Lateral Genome Transfer
  Classification: LGT
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
  query_file:
    type: string?
    doc: QUERY_FILE parameter
  use_mem:
    type: string?
    doc: USE_MEM parameter
  mismatch_penalty:
    type: int?
    default: 3
    doc: MISMATCH_PENALTY parameter
  max_gap_opens:
    type: int?
    default: 1
    doc: MAX_GAP_OPENS parameter
  max_gap_extns:
    type: string?
    default: "-1"
    doc: MAX_GAP_EXTNS parameter
  gap_open_penalty:
    type: int?
    default: 11
    doc: GAP_OPEN_PENALTY parameter
  gap_extn_penalty:
    type: int?
    default: 4
    doc: GAP_EXTN_PENALTY parameter
  max_threads:
    type: int?
    default: 1
    doc: MAX_THREADS parameter
  max_align:
    type: int?
    default: 1
    doc: MAX_ALIGN parameter
  softclip_min:
    type: int?
    default: 24
    doc: SOFTCLIP_MIN parameter
  keep_mm:
    type: int?
    default: 1
    doc: KEEP_MM parameter
  paired:
    type: string?
    doc: PAIRED parameter
  bwa_args:
    type: string?
    doc: BWA_ARGS parameter
  sam_view_args:
    type: string?
    doc: SAM_VIEW_ARGS parameter
  sam_sort_args:
    type: string?
    doc: SAM_SORT_ARGS parameter

outputs:
  bam_output:
    type: File
    outputBinding:
      glob: "*.bam"
    doc: bam format output
