cwlVersion: v1.2
class: CommandLineTool
id: prodigal
label: prodigal
doc: |
  none
  Classification: feature prediction / genes
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [prodigal]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  prodigal_opts:
    type: string?
    default: "-c"
    doc: PRODIGAL_OPTS parameter
  translation_table:
    type: string?
    doc: TRANSLATION_TABLE parameter
  project_abbreviation:
    type: string?
    doc: PROJECT_ABBREVIATION parameter

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
