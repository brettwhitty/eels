cwlVersion: v1.2
class: CommandLineTool
id: ncbi-blastn_compress_ncbi-blastn_compress
label: ncbi-blastn_compress from ncbi-blastn_compress component
doc: Tool execution from Ergatis ncbi-blastn_compress component (TIGR/JCVI/IGS)
baseCommand:
- zcat -f $;I_FILE_PATH$; | $;BLASTALL_EXEC$;
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
