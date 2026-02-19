cwlVersion: v1.2
class: CommandLineTool
id: core_qiime
label: core_qiime
doc: |
  none
  Classification: phylogenetic
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
  qiime_path:
    type: string?
    default: "/opt/opt-packages/qiime-1.8/qiime-1.8.0-release"
    doc: QIIME_PATH parameter
  reference_fasta:
    type: string?
    default: "/mnt/staging/data/clovr-greengenes-db/rep_set/97_otus.fasta"
    doc: REFERENCE_FASTA parameter

outputs:
  results_output:
    type: File
    outputBinding:
      glob: "*.results"
    doc: results format output
  table_output:
    type: File
    outputBinding:
      glob: "*.table"
    doc: table format output
  paired_table_output:
    type: File
    outputBinding:
      glob: "*.paired_table"
    doc: paired_table format output
