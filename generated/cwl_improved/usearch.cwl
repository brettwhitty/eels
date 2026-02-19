cwlVersion: v1.2
class: CommandLineTool
id: usearch
label: usearch
doc: |
  Ergatis component: usearch
  Classification: clustering
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [usearch]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  algorithm:
    type: string?
    default: "[cluster_fast|cluster_smallmem|derep_fullength|derep_prefix|usearch_global|usearch_local|sortbylength]"
    doc: ALGORITHM parameter
  other_args:
    type: string?
    doc: OTHER_ARGS parameter

outputs:
  fasta_output:
    type: File
    outputBinding:
      glob: "*.fasta"
    doc: fasta format output
  clusters_output:
    type: File
    outputBinding:
      glob: "*.clusters"
    doc: clusters format output
  usearch_output:
    type: File
    outputBinding:
      glob: "*.usearch"
    doc: usearch format output
