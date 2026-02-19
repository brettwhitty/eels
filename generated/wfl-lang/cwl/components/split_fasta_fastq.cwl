cwlVersion: v1.2
class: CommandLineTool
id: split_fasta_fastq
label: split_fasta_fastq
doc: |
  none
  Classification: sequence / manipulation
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [split_fasta_fastq]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  format:
    type: string?
    default: "fasta"
    doc: FORMAT parameter
  seqs_per_file:
    type: int?
    default: 1
    doc: SEQS_PER_FILE parameter
  total_files:
    type: string?
    doc: TOTAL_FILES parameter
  files_per_directory:
    type: string?
    doc: FILES_PER_DIRECTORY parameter

outputs:
  output_list_output:
    type: File
    outputBinding:
      glob: "*.output_list"
    doc: output_list format output
