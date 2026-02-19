cwlVersion: v1.2
class: CommandLineTool
id: fastq_to_CA
label: fastq_to_CA
doc: |
  none
  Classification: file / conversion
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
  library:
    type: string?
    doc: LIBRARY parameter
  fastq_type:
    type: string?
    default: "illumina"
    doc: FASTQ_TYPE parameter
  insert_size:
    type: string?
    doc: INSERT_SIZE parameter
  orientation:
    type: string?
    default: "innie"
    doc: ORIENTATION parameter

outputs:
  frg_output:
    type: File
    outputBinding:
      glob: "*.frg"
    doc: frg format output
