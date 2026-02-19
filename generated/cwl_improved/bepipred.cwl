cwlVersion: v1.2
class: CommandLineTool
id: bepipred
label: bepipred
doc: |
  none
  Classification: functional prediction
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [replace_fasta_headers.pl]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  threshold:
    type: float?
    default: 0.35
    doc: THRESHOLD parameter
  leave_fasta_headers:
    type: string?
    doc: LEAVE_FASTA_HEADERS parameter

outputs:
  raw_output:
    type: File
    outputBinding:
      glob: "*.txt"
    doc: raw format output
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
