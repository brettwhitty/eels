cwlVersion: v1.2
class: CommandLineTool
id: bowtie_build
label: bowtie_build
doc: |
  generates bowtie index files for the given reference fasta file
  Classification: RNA-Seq
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [bowtie_build]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  bowtie_bin_dir:
    type: string?
    default: "$;BOWTIE_BUILD_BIN$;"
    doc: BOWTIE_BIN_DIR parameter
  bowtie_index_prefix:
    type: string?
    default: "ref"
    doc: BOWTIE_INDEX_PREFIX parameter
  other_parameters:
    type: string?
    doc: OTHER_PARAMETERS parameter
  other_args:
    type: string?
    default: "--v"
    doc: OTHER_ARGS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
