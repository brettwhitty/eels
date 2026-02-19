cwlVersion: v1.2
class: CommandLineTool
id: cuffdiff_filter
label: cuffdiff_filter
doc: |
  Filters cuffdiff output based on FDR,P value,Log fold change, FPKM.
  Classification: RNA-Seq
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [cuffdiff_filter]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  other_parameters:
    type: string?
    doc: OTHER_PARAMETERS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
