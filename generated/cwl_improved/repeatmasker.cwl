cwlVersion: v1.2
class: CommandLineTool
id: repeatmasker
label: repeatmasker
doc: |
  none
  Classification: sequence / masking
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [repeatmasker]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  repeat_def:
    type: string?
    default: "-lib $;SIMPLE_REPEAT_LIB$;"
    doc: REPEAT_DEF parameter
  cutoff:
    type: int?
    default: 225
    doc: CUTOFF parameter
  other_opts:
    type: string?
    default: "-q"
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
