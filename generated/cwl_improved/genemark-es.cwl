cwlVersion: v1.2
class: CommandLineTool
id: genemark-es
label: genemark-es
doc: |
  none
  Classification: feature prediction / genes
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [run_genemark-es]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  other_opts:
    type: string?
    doc: OTHER_OPTS parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
  gtf_output:
    type: File
    outputBinding:
      glob: "*.gtf"
    doc: gtf format output
