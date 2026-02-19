cwlVersion: v1.2
class: CommandLineTool
id: bowtie
label: bowtie
doc: |
  generates bowtie alignment for the input sequence file(s) against the given reference index file.
  Classification: RNA-Seq
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [bowtie]

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
    default: "$;BOWTIE_BIN$;"
    doc: BOWTIE_BIN_DIR parameter
  samtools_bin_dir:
    type: string?
    default: "$;SAMTOOLS_BIN$;"
    doc: SAMTOOLS_BIN_DIR parameter
  mode:
    type: string?
    default: "v"
    doc: MODE parameter
  num_mismatches:
    type: int?
    default: 2
    doc: NUM_MISMATCHES parameter
  file_type:
    type: string?
    default: "fastq"
    doc: FILE_TYPE parameter
  seed_length:
    type: string?
    doc: SEED_LENGTH parameter
  min_insert:
    type: string?
    doc: MIN_INSERT parameter
  max_insert:
    type: string?
    doc: MAX_INSERT parameter
  library_type:
    type: string?
    doc: LIBRARY_TYPE parameter
  num_hits:
    type: string?
    doc: NUM_HITS parameter
  max_multihits:
    type: string?
    doc: MAX_MULTIHITS parameter
  report_multihits:
    type: string?
    doc: REPORT_MULTIHITS parameter
  unmapped_reads:
    type: string?
    default: "unmapped_sequence.txt"
    doc: UNMAPPED_READS parameter
  num_threads:
    type: string?
    doc: NUM_THREADS parameter
  other_parameters:
    type: string?
    default: "--sam"
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
