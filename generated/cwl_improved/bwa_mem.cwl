cwlVersion: v1.2
class: CommandLineTool
id: bwa_mem
label: bwa_mem
doc: |
  BWA mem aligner
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
  min_seed_length:
    type: int?
    default: 19
    doc: MIN_SEED_LENGTH parameter
  mismatch_penalty:
    type: int?
    default: 4
    doc: MISMATCH_PENALTY parameter
  gap_open_penalty:
    type: int?
    default: 6
    doc: GAP_OPEN_PENALTY parameter
  gap_extn_penalty:
    type: int?
    default: 1
    doc: GAP_EXTN_PENALTY parameter
  alignment_score_thresh:
    type: int?
    default: 30
    doc: ALIGNMENT_SCORE_THRESH parameter
  max_threads:
    type: int?
    default: 1
    doc: MAX_THREADS parameter
  other_opts:
    type: string?
    doc: OTHER_OPTS parameter

outputs:
  sam_output:
    type: File
    outputBinding:
      glob: "*.sam"
    doc: sam format output
