cwlVersion: v1.2
class: CommandLineTool
id: lgt_bwa_fq
label: lgt_bwa_fq
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
  bwasw:
    type: string?
    doc: BWASW parameter
  max_align:
    type: int?
    default: 1000
    doc: MAX_ALIGN parameter
  cleanup:
    type: int?
    default: 1
    doc: CLEANUP parameter
  ref_file1:
    type: string?
    doc: REF_FILE1 parameter
  ref_file2:
    type: string?
    doc: REF_FILE2 parameter
  ref_file_list1:
    type: string?
    doc: REF_FILE_LIST1 parameter
  ref_file_list2:
    type: string?
    doc: REF_FILE_LIST2 parameter

outputs:
  sam_output:
    type: File
    outputBinding:
      glob: "*.sam"
    doc: sam format output
