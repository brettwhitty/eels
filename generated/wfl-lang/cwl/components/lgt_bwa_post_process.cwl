cwlVersion: v1.2
class: CommandLineTool
id: lgt_bwa_post_process
label: lgt_bwa_post_process
doc: |
  Post processing of aligned and filtered reads to detect LGT
  Classification: LGT
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
  donor_file_list:
    type: string?
    doc: DONOR_FILE_LIST parameter
  recipient_file_list:
    type: string?
    doc: RECIPIENT_FILE_LIST parameter
  donor_file:
    type: string?
    doc: DONOR_FILE parameter
  recipient_file:
    type: string?
    doc: RECIPIENT_FILE parameter

outputs:
  mb_bam_output:
    type: File
    outputBinding:
      glob: "*.mb_bam"
    doc: mb_bam format output
  lgt_h_bam_output:
    type: File
    outputBinding:
      glob: "*.lgt_h_bam"
    doc: lgt_h_bam format output
  single_bam_output:
    type: File
    outputBinding:
      glob: "*.single_bam"
    doc: single_bam format output
  no_map_bam_output:
    type: File
    outputBinding:
      glob: "*.no_map_bam"
    doc: no_map_bam format output
  single_paired_bam_output:
    type: File
    outputBinding:
      glob: "*.single_paired_bam"
    doc: single_paired_bam format output
