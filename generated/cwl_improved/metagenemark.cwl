cwlVersion: v1.2
class: CommandLineTool
id: metagenemark
label: metagenemark
doc: |
  none
  Classification: feature prediction / genes
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [metagenemark]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  training_model:
    type: string?
    default: "$;MGM_DEFAULT_MODEL$;"
    doc: TRAINING_MODEL parameter
  other_opts:
    type: string?
    default: "-a -d"
    doc: OTHER_OPTS parameter

outputs:
  gff_output:
    type: File
    outputBinding:
      glob: "*.gff"
    doc: gff format output
