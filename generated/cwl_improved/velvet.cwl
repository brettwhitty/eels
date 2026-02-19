cwlVersion: v1.2
class: CommandLineTool
id: velvet
label: velvet
doc: |
  none
  Classification: assembly
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [mkdir]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  file_format:
    type: string?
    default: "[-fasta|-fastq|-fasta.gz|-fastq.gz|-eland|-gerald| ]"
    doc: FILE_FORMAT parameter
  read_type:
    type: string?
    default: "[-short|-shortPaired|-short2|-shortPaired2|-long|-longPaired]"
    doc: READ_TYPE parameter
  hash_length:
    type: string?
    doc: HASH_LENGTH parameter
  velveth_opts:
    type: string?
    doc: VELVETH_OPTS parameter
  velvetg_opts:
    type: string?
    doc: VELVETG_OPTS parameter

outputs:
  sequence_output:
    type: File
    outputBinding:
      glob: "*.sequence"
    doc: sequence format output
  roadmap_output:
    type: File
    outputBinding:
      glob: "*.roadmap"
    doc: roadmap format output
  contig_output:
    type: File
    outputBinding:
      glob: "*.contig"
    doc: contig format output
  stats_output:
    type: File
    outputBinding:
      glob: "*.stats"
    doc: stats format output
  graph_output:
    type: File
    outputBinding:
      glob: "*.graph"
    doc: graph format output
  amos_output:
    type: File
    outputBinding:
      glob: "*.amos"
    doc: amos format output
