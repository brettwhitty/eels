cwlVersion: v1.2
class: CommandLineTool
id: filter_deseq
label: filter_deseq
doc: |
  Filters deseq output based on FDR,P value,Log fold change, Read count.
  Classification: RNA-Seq
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [filter_deseq]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  mapfile_path:
    type: string?
    doc: MAPFILE_PATH parameter
  other_parameters:
    type: string?
    doc: OTHER_PARAMETERS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
