cwlVersion: v1.2
class: CommandLineTool
id: dump_table
label: dump_table
doc: |
  Dump a database into a tbl file and prepares it for GenBank submission
  Classification: utility
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [dump_table]

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
    default: "manatee-db"
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
  delete_url:
    type: string?
    default: "http://manatee.igs.umaryland.edu/tigr-scripts/chado_prok_manatee/delete_gene.cgi"
    doc: DELETE_URL parameter
  linker_sequence:
    type: string?
    default: "NNNNNCACACACTTAATTAATTAAGTGTGTGNNNNN"
    doc: LINKER_SEQUENCE parameter
  contig_string:
    type: string?
    default: "contig"
    doc: CONTIG_STRING parameter
  db_name:
    type: string?
    default: "NCBI_locus_tag"
    doc: DB_NAME parameter
  contig_id_replacement:
    type: string?
    default: "gene"
    doc: CONTIG_ID_REPLACEMENT parameter
  other_tbl2asn_opts:
    type: string?
    default: "-c bf"
    doc: OTHER_TBL2ASN_OPTS parameter
  args:
    type: string?
    doc: ARGS parameter
  min_contig_len:
    type: int?
    default: 200
    doc: MIN_CONTIG_LEN parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
