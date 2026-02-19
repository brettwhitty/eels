cwlVersion: v1.2
class: CommandLineTool
id: bwa
label: bwa
doc: |
  BWA aligner
  Classification: alignment
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
  cleanup:
    type: int?
    default: 1
    doc: CLEANUP parameter
  index_bam:
    type: int?
    default: 1
    doc: INDEX_BAM parameter
  query_input_list:
    type: string?
    doc: QUERY_INPUT_LIST parameter

outputs:
  bam_output:
    type: File
    outputBinding:
      glob: "*.bam"
    doc: bam format output
