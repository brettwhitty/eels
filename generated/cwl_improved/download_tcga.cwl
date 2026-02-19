cwlVersion: v1.2
class: CommandLineTool
id: download_tcga
label: download_tcga
doc: |
  none
  Classification: utility
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
  genetorrent_bin:
    type: string?
    default: "/home/ksieber/bin/"
    doc: GENETORRENT_BIN parameter
  cghub_key:
    type: string?
    default: "/local/projects-t3/HLGT/TCGA/key_dir/cghub.key"
    doc: CGHUB_KEY parameter
  tcga_id:
    type: string?
    doc: TCGA_ID parameter
  num_retries:
    type: string?
    doc: NUM_RETRIES parameter
  rate_limit:
    type: int?
    default: 200
    doc: RATE_LIMIT parameter

outputs:
  output_list_output:
    type: File
    outputBinding:
      glob: "*.output_list"
    doc: output_list format output
