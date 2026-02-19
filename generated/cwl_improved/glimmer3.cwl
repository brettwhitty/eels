cwlVersion: v1.2
class: CommandLineTool
id: glimmer3
label: glimmer3
doc: |
  none
  Classification: feature prediction / genes
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [glimmer3]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  training_seq:
    type: string?
    doc: TRAINING_SEQ parameter
  icm:
    type: string?
    default: "$;OUTPUT_DIRECTORY$;/$;COMPONENT_NAME$;.icm"
    doc: ICM parameter
  long_orfs_opts:
    type: string?
    default: "-n -t 1.15"
    doc: LONG_ORFS_OPTS parameter
  glimmer3_opts:
    type: string?
    doc: GLIMMER3_OPTS parameter
  start_codon_usage:
    type: string?
    doc: START_CODON_USAGE parameter
  project_abbreviation:
    type: string?
    default: "$;PROJECT$;"
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
