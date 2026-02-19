cwlVersion: v1.2
class: CommandLineTool
id: bam2sam
label: bam2sam
doc: |
  converts SAM files to indexed BAM
  Classification: RNA-Seq
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
  view_options:
    type: string?
    default: "-h"
    doc: VIEW_OPTIONS parameter
  sort_options:
    type: string?
    doc: SORT_OPTIONS parameter
  input_bam_file:
    type: string?
    default: "/local/projects/ifx_core/rna_seq/tcreasy/rna_seq/output_repository/sam2bam/185_default/test.name_sorted.bam"
    doc: INPUT_BAM_FILE parameter
  other_args:
    type: string?
    doc: OTHER_ARGS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
