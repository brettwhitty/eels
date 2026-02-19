cwlVersion: v1.2
class: CommandLineTool
id: bam2bigwig
label: bam2bigwig
doc: |
  converts alignment BAM files to BedGraph and BigWig formats for visualization
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
  stranded:
    type: string?
    doc: STRANDED parameter
  ucsc_util_dir:
    type: string?
    default: "$;UCSC_UTIL$;"
    doc: UCSC_UTIL_DIR parameter
  bedtools_bin_dir:
    type: string?
    default: "$;BEDTOOLS_BIN$;"
    doc: BEDTOOLS_BIN_DIR parameter
  samtools_bin_dir:
    type: string?
    default: "$;SAMTOOLS_BIN$;"
    doc: SAMTOOLS_BIN_DIR parameter
  other_args:
    type: string?
    default: "--v"
    doc: OTHER_ARGS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
