cwlVersion: v1.2
class: CommandLineTool
id: summarize_mugsy_comparative_pipeline
label: summarize_mugsy_comparative_pipeline
doc: |
  NA
  Classification: comparative
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

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
