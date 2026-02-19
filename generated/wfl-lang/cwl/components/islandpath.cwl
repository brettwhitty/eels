cwlVersion: v1.2
class: CommandLineTool
id: islandpath
label: islandpath
doc: |
  none
  Classification: unclassified
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [islandpath]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  dimob_path:
    type: string?
    default: "/usr/local/bin/dimob.pl"
    doc: DIMOB_PATH parameter
  other_opts:
    type: string?
    default: "--hmmer2"
    doc: OTHER_OPTS parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
  raw_output:
    type: File
    outputBinding:
      glob: "*.txt"
    doc: raw format output
  fasta_output:
    type: File
    outputBinding:
      glob: "*.fasta"
    doc: fasta format output
