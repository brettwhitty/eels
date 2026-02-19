cwlVersion: v1.2
class: CommandLineTool
id: gkpstore2fastq
label: gkpstore2fastq
doc: |
  Filter fastq files
  Classification: utility
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [cat]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file

outputs:
  fastq_output:
    type: File
    outputBinding:
      glob: "*.fastq"
    doc: fastq format output
