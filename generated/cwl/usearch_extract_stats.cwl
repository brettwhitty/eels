cwlVersion: v1.2
class: CommandLineTool
id: usearch_extract stats
label: extract stats from usearch component
doc: Tool execution from Ergatis usearch component (TIGR/JCVI/IGS)
baseCommand:
- tail -10 $;TMP_DIR$;/$;ITERATOR_NAME$;/g$;GROUP_NUMBER$;/$;I_FILE_BASE$;.stderr
  >> $;OUTPUT_DIRECTORY$;/stats.txt;
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
