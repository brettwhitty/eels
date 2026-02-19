cwlVersion: v1.2
class: CommandLineTool
id: percent_mapped_stats
label: percent_mapped_stats
doc: |
  Calculates percentage of reads mapping to exonic/intronic/intergenic region for euk and genic/intergenic for prok.
  Classification: RNA-Seq
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [percent_mapped_stats]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  bedtools_bin_dir:
    type: string?
    default: "$;BEDTOOLS_BIN$;"
    doc: BEDTOOLS_BIN_DIR parameter
  samtools_bin_dir:
    type: string?
    default: "$;SAMTOOLS_BIN$;"
    doc: SAMTOOLS_BIN_DIR parameter
  other_parameters:
    type: string?
    doc: OTHER_PARAMETERS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
