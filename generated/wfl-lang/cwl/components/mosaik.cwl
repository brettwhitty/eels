cwlVersion: v1.2
class: CommandLineTool
id: mosaik
label: mosaik
doc: |
  aligns reads against a single reference file contining one or more contigs
  Classification: alignment
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
  fr:
    type: string?
    doc: FR parameter
  fr2:
    type: string?
    doc: FR2 parameter
  fq:
    type: string?
    doc: FQ parameter
  fq2:
    type: string?
    doc: FQ2 parameter
  q:
    type: string?
    doc: Q parameter
  q2:
    type: string?
    doc: Q2 parameter
  st:
    type: string?
    default: "illumina"
    doc: ST parameter
  other_build_opts:
    type: string?
    doc: OTHER_BUILD_OPTS parameter
  hs:
    type: int?
    default: 15
    doc: HS parameter
  mm:
    type: int?
    default: 2
    doc: MM parameter
  m:
    type: string?
    default: "all"
    doc: M parameter
  mhp:
    type: int?
    default: 100
    doc: MHP parameter
  act:
    type: int?
    default: 20
    doc: ACT parameter
  p:
    type: int?
    default: 1
    doc: P parameter
  other_align_opts:
    type: string?
    doc: OTHER_ALIGN_OPTS parameter
  other_sort_opts:
    type: string?
    doc: OTHER_SORT_OPTS parameter
  form:
    type: string?
    default: "ace"
    doc: FORM parameter
  other_assembler_opts:
    type: string?
    doc: OTHER_ASSEMBLER_OPTS parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
