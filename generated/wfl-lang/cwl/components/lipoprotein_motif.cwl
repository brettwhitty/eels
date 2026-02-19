cwlVersion: v1.2
class: CommandLineTool
id: lipoprotein_motif
label: lipoprotein_motif
doc: |
  none
  Classification: functional prediction
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [lipoprotein_motif]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  is_mycoplasm:
    type: string?
    doc: IS_MYCOPLASM parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
