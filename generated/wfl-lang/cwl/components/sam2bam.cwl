cwlVersion: v1.2
class: CommandLineTool
id: sam2bam
label: sam2bam
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
    default: "-bS"
    doc: VIEW_OPTIONS parameter
  sort_options:
    type: string?
    doc: SORT_OPTIONS parameter
  input_sam_file:
    type: string?
    default: "/local/projects/ifx_core/rna_seq/tcreasy/prok_test_data/s_pyogenese/sam/test.sam"
    doc: INPUT_SAM_FILE parameter
  other_args:
    type: string?
    doc: OTHER_ARGS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
