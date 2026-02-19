cwlVersion: v1.2
class: CommandLineTool
id: intergenic_analysis
label: intergenic_analysis
doc: |
  none
  Classification: feature prediction / genes
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [intergenic_analysis]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  minimum_orf_length:
    type: int?
    default: 150
    doc: MINIMUM_ORF_LENGTH parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
