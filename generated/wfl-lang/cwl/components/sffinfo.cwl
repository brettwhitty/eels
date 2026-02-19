cwlVersion: v1.2
class: CommandLineTool
id: sffinfo
label: sffinfo
doc: |
  none
  Classification: file / conversion
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [sffinfo]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  config_params:
    type: string?
    doc: CONFIG_PARAMS parameter

outputs:
  accession_output:
    type: File
    outputBinding:
      glob: "*.accession"
    doc: accession format output
  sequence_output:
    type: File
    outputBinding:
      glob: "*.sequence"
    doc: sequence format output
  quality_output:
    type: File
    outputBinding:
      glob: "*.quality"
    doc: quality format output
  flowgram_output:
    type: File
    outputBinding:
      glob: "*.flowgram"
    doc: flowgram format output
  tab_output:
    type: File
    outputBinding:
      glob: "*.tab"
    doc: tab format output
