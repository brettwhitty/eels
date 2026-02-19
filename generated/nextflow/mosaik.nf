#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: mosaik
// Generated from Ergatis component JSON by EELS

params {
    act = ''
    form = ''
    fq = ''
    fq2 = ''
    fr = ''
    fr2 = ''
    hs = ''
    m = ''
    mhp = ''
    mm = ''
    mosaik_aligner_exec = ''
    mosaik_assembler_exec = ''
    mosaik_build_exec = ''
    mosaik_sort_exec = ''
    mosaik_text_exec = ''
    other_align_opts = ''
    other_sort_opts = ''
    output_directory = ''
    p = ''
    q = ''
    q2 = ''
    st = ''
}

process MosaikBuild_Refs {
    script:
    """
    ${params.mosaik_build_exec} -fr ${params.fr} ${params.fr2} ${params.fq} ${params.fq2} -oa ${params.output_directory}/references.dat \
        1>${params.output_directory}/buildref.stdout \
        2>{{OUTPUT_DIRECTORY}}/buildref.stderr
    """
}

process MosaikBuild_Reads {
    script:
    """
    ${params.mosaik_build_exec} -q ${params.q} ${params.q2} -out ${params.output_directory}/reads.dat -st ${params.st} \
        1>${params.output_directory}/buildread.stdout \
        2>{{OUTPUT_DIRECTORY}}/buildread.stderr
    """
}

process MosaikAligner {
    script:
    """
    ${params.mosaik_aligner_exec} -in ${params.output_directory}/reads.dat -out ${params.output_directory}/aligned.dat -ia ${params.output_directory}/references.dat -hs ${params.hs} -mm ${params.mm} -m ${params.m} -mhp ${params.mhp} -act ${params.act} -p ${params.p} ${params.other_align_opts} \
        1>${params.output_directory}/align.stdout \
        2>{{OUTPUT_DIRECTORY}}/align.stderr
    """
}

process MosaikSort {
    script:
    """
    ${params.mosaik_sort_exec} -in ${params.output_directory}/aligned.dat -out ${params.output_directory}/aligned_sorted.dat ${params.other_sort_opts} \
        1>${params.output_directory}/sort.stdout \
        2>{{OUTPUT_DIRECTORY}}/sort.stderr
    """
}

process create_assembly_file_output_directory {
    script:
    """
    mkdir -p -m 777 ${params.output_directory}/ace_files
    """
}

process MosaikAssembler {
    script:
    """
    ${params.mosaik_assembler_exec} -in ${params.output_directory}/aligned_sorted.dat -ia ${params.output_directory}/references.dat -f ${params.form} -out ${params.output_directory}/ace_files/assembled \
        1>${params.output_directory}/assemble.stdout \
        2>{{OUTPUT_DIRECTORY}}/assemble.stderr
    """
}

process MosaikText {
    script:
    """
    ${params.mosaik_text_exec} -in ${params.output_directory}/aligned_sorted.dat -sam ${params.output_directory}/aligned_sorted.sam \
        1>${params.output_directory}/text.stdout \
        2>{{OUTPUT_DIRECTORY}}/text.stderr
    """
}

process Gunzip_SAM_file {
    script:
    """
    /usr/bin/gunzip ${params.output_directory}/aligned_sorted.sam.gz \
        1>${params.output_directory}/gunzip.stdout \
        2>{{OUTPUT_DIRECTORY}}/gunzip.stderr
    """
}

workflow {
    // Serial execution chain
    MosaikBuild_Refs()
    MosaikBuild_Reads()
    MosaikAligner()
    MosaikSort()
    create_assembly_file_output_directory()
    MosaikAssembler()
    MosaikText()
    Gunzip_SAM_file()
}
