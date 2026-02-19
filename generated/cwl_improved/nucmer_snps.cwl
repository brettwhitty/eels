cwlVersion: v1.2
class: CommandLineTool
id: nucmer_snps
label: nucmer_snps
doc: |
  none
  Classification: alignment / multiple
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [nucmer]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  breaklen:
    type: int?
    default: 200
    doc: BREAKLEN parameter
  mincluster:
    type: int?
    default: 65
    doc: MINCLUSTER parameter
  diagfactor:
    type: float?
    default: 0.12
    doc: DIAGFACTOR parameter
  maxgap:
    type: int?
    default: 90
    doc: MAXGAP parameter
  minmatch:
    type: int?
    default: 20
    doc: MINMATCH parameter
  show_snps_opts:
    type: string?
    default: "-C"
    doc: SHOW_SNPS_OPTS parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
