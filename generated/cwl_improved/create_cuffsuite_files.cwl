cwlVersion: v1.2
class: CommandLineTool
id: create_cuffsuite_files
label: create_cuffsuite_files
doc: |
  Generates cuffcompare and cuffdiff input list files
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
  gtffile:
    type: string?
    doc: GTFFILE parameter
  gtf_listfile:
    type: string?
    doc: GTF_LISTFILE parameter
  sam_listfile:
    type: string?
    doc: SAM_LISTFILE parameter
  other_args:
    type: string?
    default: "--v"
    doc: OTHER_ARGS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
