cwlVersion: v1.2
class: CommandLineTool
id: extract_assembly_stats
label: extract_assembly_stats
doc: |
  extracts assembly statistics
  Classification: assembly
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [extract_assembly_stats]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  limit:
    type: string?
    doc: LIMIT parameter
  n50_base:
    type: string?
    doc: N50_BASE parameter

outputs:
  output_list_output:
    type: File
    outputBinding:
      glob: "*.output_list"
    doc: output_list format output
