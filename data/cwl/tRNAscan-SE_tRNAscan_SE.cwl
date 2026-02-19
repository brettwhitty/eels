cwlVersion: v1.2
class: CommandLineTool
id: tRNAscan-SE_tRNAscan-SE
label: tRNAscan-SE from tRNAscan-SE component
doc: Tool execution from Ergatis tRNAscan-SE component (TIGR/JCVI/IGS)
baseCommand:
- export TMPDIR=$;TMP_DIR$;; perl -I $;TRNASCAN_LIB$; $;TRNASCANSE_EXEC$;
inputs:
  input_file:
    type: File
    inputBinding:
      position: 1
outputs:
  output_file:
    type: File
    outputBinding:
      glob: '*.out'
