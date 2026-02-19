#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: nucmer_snps
// Generated from Ergatis component JSON by EELS

params {
    breaklen = ''
    diagfactor = ''
    group_number = ''
    iterator_name = ''
    i_file_path1 = ''
    i_file_path2 = ''
    maxgap = ''
    mincluster = ''
    minmatch = ''
    output_directory = ''
    pair_count = ''
    show_snps_opts = ''
}

process NUCmer {
    script:
    """
    /usr/local/common/nucmer --maxmatch ${params.i_file_path1} ${params.i_file_path2} --prefix ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.pair_count} --breaklen ${params.breaklen} --mincluster ${params.mincluster} --diagfactor ${params.diagfactor} --maxgap ${params.maxgap} --minmatch ${params.minmatch}
    """
}

process delta_filter {
    script:
    """
    /usr/local/common/delta-filter -r ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.pair_count}.delta \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.pair_count}.filtered.delta
    """
}

process show_snps {
    script:
    """
    /usr/local/common/show-snps -Tl ${params.show_snps_opts} ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.pair_count}.filtered.delta \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.pair_count}.${params.component_name}.snps
    """
}

workflow {
    // Serial execution chain
    NUCmer()
    delta_filter()
    show_snps()
}
