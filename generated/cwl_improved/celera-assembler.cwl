cwlVersion: v1.2
class: CommandLineTool
id: celera-assembler
label: celera-assembler
doc: |
  none
  Classification: sequence / assembly
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
  spec_file:
    type: string?
    default: "/dev/null"
    doc: SPEC_FILE parameter

outputs:
  asm_output:
    type: File
    outputBinding:
      glob: "*.asm"
    doc: asm format output
  qc_output:
    type: File
    outputBinding:
      glob: "*.qc"
    doc: qc format output
  chimera_summary_output:
    type: File
    outputBinding:
      glob: "*.chimera_summary"
    doc: chimera_summary format output
  chimera_report_output:
    type: File
    outputBinding:
      glob: "*.chimera_report"
    doc: chimera_report format output
  merge_log_output:
    type: File
    outputBinding:
      glob: "*.merge_log"
    doc: merge_log format output
  scf_fasta_output:
    type: File
    outputBinding:
      glob: "*.scf_fasta"
    doc: scf_fasta format output
