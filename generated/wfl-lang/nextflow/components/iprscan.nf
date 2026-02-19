#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: iprscan
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_config = ''
    component_name = ''
    compress_bsml_output = ''
    docs_dir = ''
    ergatis_dir = ''
    group_number = ''
    iprscan_exec = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
    pipeline_xml = ''
    seq_type = ''
    workflow_repository = ''
}

process blastprodom {
    script:
    """
    ${params.iprscan_exec} -cli -nocrc -iprlookup -goterms -appl blastprodom -seqtype ${params.seq_type} -format raw -i ${params.i_file_path} -o ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.blastprodom.raw
    """
}

process coils {
    script:
    """
    ${params.iprscan_exec} -cli -nocrc -iprlookup -goterms -appl coils -seqtype ${params.seq_type} -format raw -i ${params.i_file_path} -o ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.coils.raw
    """
}

process hmmpir {
    script:
    """
    ${params.iprscan_exec} -cli -nocrc -iprlookup -goterms -appl hmmpir -seqtype ${params.seq_type} -format raw -i ${params.i_file_path} -o ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.hmmpir.raw
    """
}

process hmmpfam {
    script:
    """
    ${params.iprscan_exec} -cli -nocrc -iprlookup -goterms -appl hmmpfam -seqtype ${params.seq_type} -format raw -i ${params.i_file_path} -o ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.hmmpfam.raw
    """
}

process hmmsmart {
    script:
    """
    ${params.iprscan_exec} -cli -nocrc -iprlookup -goterms -appl hmmsmart -seqtype ${params.seq_type} -format raw -i ${params.i_file_path} -o ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.hmmsmart.raw
    """
}

process hmmtigr {
    script:
    """
    ${params.iprscan_exec} -cli -nocrc -iprlookup -goterms -appl hmmtigr -seqtype ${params.seq_type} -format raw -i ${params.i_file_path} -o ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.hmmtigr.raw
    """
}

process fprintscan {
    script:
    """
    ${params.iprscan_exec} -cli -nocrc -iprlookup -goterms -appl fprintscan -seqtype ${params.seq_type} -format raw -i ${params.i_file_path} -o ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.fprintscan.raw
    """
}

process scanregexp {
    script:
    """
    ${params.iprscan_exec} -cli -nocrc -iprlookup -goterms -appl scanregexp -seqtype ${params.seq_type} -format raw -i ${params.i_file_path} -o ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.scanregexp.raw
    """
}

process profilescan {
    script:
    """
    ${params.iprscan_exec} -cli -nocrc -iprlookup -goterms -appl profilescan -seqtype ${params.seq_type} -format raw -i ${params.i_file_path} -o ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.profilescan.raw
    """
}

process superfamily {
    script:
    """
    ${params.iprscan_exec} -cli -nocrc -iprlookup -goterms -appl superfamily -seqtype ${params.seq_type} -format raw -i ${params.i_file_path} -o ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.superfamily.raw
    """
}

process seg {
    script:
    """
    ${params.iprscan_exec} -cli -nocrc -iprlookup -goterms -appl seg -seqtype ${params.seq_type} -format raw -i ${params.i_file_path} -o ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.seg.raw
    """
}

process combine_raw_output {
    script:
    """
    find ${params.output_directory}/${params.iterator_name}/g${params.group_number}/ -type f -regex '.*${params.i_file_base}.*.raw' ! -regex '.*${params.i_file_base}.*.${params.component_name}.raw' -exec cat {} \; \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw
    """
}

process iprscan2bsml {
    script:
    """
    ${params.bin_dir}/iprscan2bsml --query_file_path ${params.i_file_path} --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --gzip_output ${params.compress_bsml_output}
    """
}

process store_config_params {
    script:
    """
    ${params.bin_dir}/analysis2bsml --ergatis_control_file ${params.ergatis_dir}.ini --conf ${params.component_config} --bsml_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --componenturl ${params.workflow_repository}/component.xml --pipelineurl ${params.pipeline_xml} --analysis_id ${params.component_name}_analysis
    """
}

process dtd_validation {
    script:
    """
    ${params.bin_dir}/dtdValid.pl ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml -d ${params.docs_dir}/bsml3_1.dtd
    """
}

workflow {
    // Serial execution chain
    blastprodom()
    coils()
    hmmpir()
    hmmpfam()
    hmmsmart()
    hmmtigr()
    fprintscan()
    scanregexp()
    profilescan()
    superfamily()
    seg()
    combine_raw_output()
    iprscan2bsml()
    store_config_params()
    dtd_validation()
}
