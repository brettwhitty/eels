cwlVersion: v1.2
class: CommandLineTool
id: solsnp_solsnp
label: solsnp from solsnp component
doc: Tool execution from Ergatis solsnp component (TIGR/JCVI/IGS)
baseCommand:
- java -jar $;SOLSNP_EXEC$;
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
