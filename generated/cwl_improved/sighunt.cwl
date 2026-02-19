cwlVersion: v1.2
class: CommandLineTool
id: sighunt
label: sighunt
doc: |
  Find lateral gene transfer in eukaryotic assemblies
  Classification: LGT
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [run_sighunt]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  r_script:
    type: string?
    default: "$;BIN_DIR$;/run_sighunt.R"
    doc: R_SCRIPT parameter
  cutoff:
    type: string?
    doc: CUTOFF parameter
  window_size:
    type: int?
    default: 5000
    doc: WINDOW_SIZE parameter
  shift:
    type: int?
    default: 1000
    doc: SHIFT parameter

outputs:
  txt_output:
    type: File
    outputBinding:
      glob: "*.txt"
    doc: txt format output
