cwlVersion: v1.2
class: CommandLineTool
id: dump_fasta
label: dump_fasta
doc: |
  Dump a database into a fasta file with contigs and prepares it for GenBank submission
  Classification: utility
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [dump_fasta]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  server:
    type: string?
    default: "jabba"
    doc: SERVER parameter
  username:
    type: string?
    doc: USERNAME parameter
  password:
    type: string?
    doc: PASSWORD parameter
  password_file:
    type: string?
    doc: PASSWORD_FILE parameter
  linker_sequence:
    type: string?
    default: "NNNNNCACACACTTAATTAATTAAGTGTGTGNNNNN"
    doc: LINKER_SEQUENCE parameter
  contig_string:
    type: string?
    default: "contig"
    doc: CONTIG_STRING parameter
  contig_id_replacement:
    type: string?
    default: "gene"
    doc: CONTIG_ID_REPLACEMENT parameter
  other_tbl2asn_opts:
    type: string?
    doc: OTHER_TBL2ASN_OPTS parameter
  min_contig_len:
    type: int?
    default: 200
    doc: MIN_CONTIG_LEN parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
