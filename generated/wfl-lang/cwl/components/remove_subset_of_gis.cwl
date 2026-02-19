cwlVersion: v1.2
class: CommandLineTool
id: remove_subset_of_gis
label: remove_subset_of_gis
doc: |
  From a list of GIs, remove GIs that fall under a specific taxa
  Classification: LGT
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
  taxon_id:
    type: string?
    doc: TAXON_ID parameter
  database:
    type: string?
    doc: DATABASE parameter

outputs:
  txt_output:
    type: File
    outputBinding:
      glob: "*.txt"
    doc: txt format output
