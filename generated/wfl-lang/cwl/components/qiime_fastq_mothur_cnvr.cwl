cwlVersion: v1.2
class: CommandLineTool
id: qiime_fastq_mothur_cnvr
label: qiime_fastq_mothur_cnvr
doc: |
  none
  Classification: preliminary
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

outputs:
  results_output:
    type: File
    outputBinding:
      glob: "*.results"
    doc: results format output
