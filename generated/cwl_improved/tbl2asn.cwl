cwlVersion: v1.2
class: CommandLineTool
id: tbl2asn
label: tbl2asn
doc: |
  none
  Classification: file / conversion
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
  organism:
    type: string?
    doc: ORGANISM parameter
  asn_template:
    type: string?
    doc: ASN_TEMPLATE parameter
  generate_genbank_files:
    type: string?
    default: "T"
    doc: GENERATE_GENBANK_FILES parameter
  perform_validation:
    type: string?
    default: "T"
    doc: PERFORM_VALIDATION parameter
  codon_table:
    type: int?
    default: 11
    doc: CODON_TABLE parameter
  other_opts:
    type: string?
    doc: OTHER_OPTS parameter
  fasta_input_list:
    type: string?
    doc: FASTA_INPUT_LIST parameter

outputs:
  sqn_output:
    type: File
    outputBinding:
      glob: "*.sqn"
    doc: sqn format output
  gbf_output:
    type: File
    outputBinding:
      glob: "*.gbf"
    doc: gbf format output
  val_output:
    type: File
    outputBinding:
      glob: "*.val"
    doc: val format output
  discrpt_output:
    type: File
    outputBinding:
      glob: "*.discrpt"
    doc: discrpt format output
