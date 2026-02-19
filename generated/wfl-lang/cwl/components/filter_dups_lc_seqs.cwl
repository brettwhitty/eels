cwlVersion: v1.2
class: CommandLineTool
id: filter_dups_lc_seqs
label: filter_dups_lc_seqs
doc: |
  Lateral Genome Transfer - filter duplicate and low_complexity seqs
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
  prefix:
    type: string?
    doc: PREFIX parameter
  rm_duplicates:
    type: int?
    default: 1
    doc: RM_DUPLICATES parameter
  rm_low_complexity:
    type: int?
    default: 1
    doc: RM_LOW_COMPLEXITY parameter
  lc_method:
    type: string?
    default: "dust"
    doc: LC_METHOD parameter
  lc_threshold:
    type: int?
    default: 7
    doc: LC_THRESHOLD parameter

outputs:
  bam_output:
    type: File
    outputBinding:
      glob: "*.bam"
    doc: bam format output
