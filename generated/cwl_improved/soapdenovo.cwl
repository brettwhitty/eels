cwlVersion: v1.2
class: CommandLineTool
id: soapdenovo
label: soapdenovo
doc: |
  novel short-read assembly method that builds denovo draft assembly for large genomes.
  Classification: assembly
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [soapdenovo]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  soapdenovo_bin:
    type: string?
    default: "$;SOAPDENOVO_EXEC$;"
    doc: SOAPDENOVO_BIN parameter
  process:
    type: string?
    default: "all"
    doc: PROCESS parameter
  kmer_size:
    type: int?
    default: 23
    doc: KMER_SIZE parameter
  other_args:
    type: string?
    default: "-R -M 3 -d 1"
    doc: OTHER_ARGS parameter

outputs:
  output_list_output:
    type: File
    outputBinding:
      glob: "*.output_list"
    doc: output_list format output
