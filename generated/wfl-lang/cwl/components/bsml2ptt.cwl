cwlVersion: v1.2
class: CommandLineTool
id: bsml2ptt
label: bsml2ptt
doc: |
  Convert BSML files to ptt
  Classification: file / conversion
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
  pid_feattype:
    type: string?
    default: "transcript"
    doc: PID_FEATTYPE parameter
  pid_field:
    type: string?
    default: "id"
    doc: PID_FIELD parameter
  gene_feattype:
    type: string?
    doc: GENE_FEATTYPE parameter
  gene_field:
    type: string?
    doc: GENE_FIELD parameter

outputs:
  ptt_output:
    type: File
    outputBinding:
      glob: "*.ptt"
    doc: ptt format output
