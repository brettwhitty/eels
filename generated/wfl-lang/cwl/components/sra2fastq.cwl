cwlVersion: v1.2
class: CommandLineTool
id: sra2fastq
label: sra2fastq
doc: |
  Convert SRA files to FASTQ format
  Classification: file / conversion
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
  data_directory:
    type: string?
    doc: DATA_DIRECTORY parameter

outputs:
  output_list_output:
    type: File
    outputBinding:
      glob: "*.output_list"
    doc: output_list format output
