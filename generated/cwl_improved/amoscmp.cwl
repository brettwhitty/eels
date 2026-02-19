cwlVersion: v1.2
class: CommandLineTool
id: amoscmp
label: amoscmp
doc: |
  none
  Classification: sequence / assembly
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
  config_options:
    type: string?
    doc: CONFIG_OPTIONS parameter
  reference_genome:
    type: string?
    doc: REFERENCE_GENOME parameter
  reference_genome_map:
    type: string?
    doc: REFERENCE_GENOME_MAP parameter

outputs:
  contig_output:
    type: File
    outputBinding:
      glob: "*.contig"
    doc: contig format output
  fasta_output:
    type: File
    outputBinding:
      glob: "*.fasta"
    doc: fasta format output
