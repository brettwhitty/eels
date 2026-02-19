cwlVersion: v1.2
class: CommandLineTool
id: remove_db_gene_syms_with_hypos_remove_db_gene_syms_with_hypotheticals
label: remove_db_gene_syms_with_hypotheticals from remove_db_gene_syms_with_hypos
  component
doc: Tool execution from Ergatis remove_db_gene_syms_with_hypos component (TIGR/JCVI/IGS)
baseCommand:
- remove_db_gene_syms_with_hypotheticals
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
