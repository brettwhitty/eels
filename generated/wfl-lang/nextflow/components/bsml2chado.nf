#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: bsml2chado
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    database = ''
    debug = ''
    docs_dir = ''
    iterator8 = ''
    password = ''
    password_file = ''
    rdbms = ''
    sequence_type = ''
    server = ''
    sort_chunk_size = ''
    tmp_dir = ''
    update = ''
    username = ''
    workflow_repository = ''
}

process create_cache_directory {
    script:
    """
    mkdir -p -m 777 ${params.tmp_dir}/cache_dir
    """
}

process create_parse_temp_directory {
    script:
    """
    mkdir -p -m 777 ${params.tmp_dir}/parse
    """
}

process Cache_primary_keys {
    script:
    """
    ${params.bin_dir}/queries2Chado --database ${params.database} --database_type ${params.rdbms} --server ${params.server} --username ${params.username} --password ${params.password} --password_file ${params.password_file} --debug_level ${params.debug} --update ${params.update} --type ${params.sequence_type} --log4perl ${params.workflow_repository}/queries2Chado.pl.log --cache_dir ${params.tmp_dir}/cache_dir \
        1>${params.workflow_repository}/queries2Chado.stdout \
        2>{{WORKFLOW_REPOSITORY}}/queries2Chado.stderr
    """
}

process list_bcp_files {
    script:
    """
    /usr/bin/find ${params.tmp_dir}/parse -name "*.out" -type f -noleaf \
        1>${params.tmp_dir}/tables.out
    """
}

process trim_dups_files {
    script:
    """
    cat  ${params.tmp_dir}/tables.out | perl -ne 's/.*\/([\w_]+).out/$1/;print '| sort | uniq \
        1>${params.tmp_dir}/collatetables.list.tmp \
        2>{{TMP_DIR}}/collatesort.stderr
    """
}

process create_tables_list {
    script:
    """
    echo -e "\0044;I_TABLE_NAME\0044;" | cat - ${params.tmp_dir}/collatetables.list.tmp \
        1>${params.tmp_dir}/collatetables.list
    """
}

process extract_checksums {
    script:
    """
    ${params.bin_dir}/extract_checksums --bcp_dir ${params.tmp_dir}/ --bcp_extension bcp.out --database_type ${params.rdbms} --output_file ${params.tmp_dir}/checksums.out \
        1>${params.workflow_repository}/extract_checksums.stdout \
        2>{{WORKFLOW_REPOSITORY}}/extract_checksums.stderr
    """
}

process mkdir_splitchecksums {
    script:
    """
    mkdir -p -m 777 ${params.tmp_dir}/splitchecksums
    """
}

process split {
    script:
    """
    split  -d -l ${params.sort_chunk_size} ${params.tmp_dir}/checksums.out  ${params.tmp_dir}/splitchecksums/checksums.out.split.
    """
}

process create_sort_checksums_temp_directory {
    script:
    """
    mkdir -p -m 777 ${params.tmp_dir}/${params.iterator8}
    """
}

process merge_sorted_split_checksum_files {
    script:
    """
    ${params.bin_dir}/merge_sorted_files  ${params.tmp_dir}/sortedfiles.list ${params.tmp_dir}/checksums.out.sorted -k1,1 -k2,2n -T ${params.tmp_dir}
    """
}

process assign_primary_keys {
    script:
    """
    ${params.bin_dir}/assign_pks --database ${params.database} --database_type ${params.rdbms} --server ${params.server} --username ${params.username} --password ${params.password} --password_file ${params.password_file} --debug ${params.debug} --checksum_file ${params.tmp_dir}/checksums.out.sorted --output_file ${params.tmp_dir}/checksums.out.sorted.pks
    """
}

process create_splitoffsets_directory {
    script:
    """
    mkdir -p -m 777 ${params.tmp_dir}/splitoffsets
    """
}

process split {
    script:
    """
    split  -d -l 1000000000 ${params.tmp_dir}/checksums.out.sorted.pks ${params.tmp_dir}/splitoffsets/checksums.out.splitoffsets.
    """
}

process merge_sorted_split_checksum_files {
    script:
    """
    ${params.bin_dir}/merge_sorted_files  ${params.tmp_dir}/sortedoffsetsfiles.list ${params.tmp_dir}/checksums.out.sorted.pks.offsets -k1,1 -k2,2n -T ${params.tmp_dir}
    """
}

process replace_checksums {
    script:
    """
    ${params.bin_dir}/replace_checksums --bcp_dir ${params.tmp_dir} --output_dir ${params.tmp_dir}/final --bcp_extension bcp.out --checksum_file ${params.tmp_dir}/checksums.out.sorted.pks.offsets \
        1>${params.tmp_dir}/replace_checksums.stdout \
        2>{{TMP_DIR}}/replace_checksums.stderr
    """
}

process Drop_chado_mart_indices {
    script:
    """
    ${params.bin_dir}/ddl2iterator --database_type ${params.rdbms} --infile ${params.docs_dir}/ddls/${params.rdbms}/drop_cm_indices.${params.rdbms}.ddl --outfile ${params.tmp_dir}/drop_cm_indices.list --logfile ${params.tmp_dir}/ddl2iterator.pl.drop_cm_indices.log \
        1>${params.tmp_dir}/ddl2iterator.pl.drop_cm_indices.stdout \
        2>{{TMP_DIR}}/ddl2iterator.pl.drop_cm_indices.stderr
    """
}

process Drop_indexes {
    script:
    """
    ${params.bin_dir}/ddl2iterator --database_type ${params.rdbms} --infile ${params.docs_dir}/ddls/${params.rdbms}/drop_indexes.${params.rdbms}.ddl --outfile ${params.tmp_dir}/drop_indexes.list --logfile ${params.tmp_dir}/ddl2iterator.pl.drop_indexes.log \
        1>${params.tmp_dir}/ddl2iterator.pl.drop_indexes.stdout \
        2>{{TMP_DIR}}/ddl2iterator.pl.drop_indexes.stderr
    """
}

process list_bcp_files {
    script:
    """
    ${params.bin_dir}/bcpdir2iterator --bcp_directory ${params.tmp_dir}/final --bcp_extension bcp.out --output_iterator_list ${params.tmp_dir}/bcp.out.list
    """
}

process Rebuild_indexes {
    script:
    """
    ${params.bin_dir}/ddl2iterator --infile ${params.docs_dir}/ddls/${params.rdbms}/create_indexes.${params.rdbms}.ddl --outfile ${params.tmp_dir}/create_indexes.list --logfile ${params.tmp_dir}/ddl2iterator.pl.create_indexes.log \
        1>${params.tmp_dir}/ddl2iterator.pl.create_indexes.stdout \
        2>{{TMP_DIR}}/ddl2iterator.pl.create_indexes.stderr
    """
}

process Restore_chado_mart_indices {
    script:
    """
    ${params.bin_dir}/ddl2iterator --infile ${params.docs_dir}/ddls/${params.rdbms}/create_cm_indices.${params.rdbms}.ddl --outfile ${params.tmp_dir}/create_cm_indices.list --logfile ${params.tmp_dir}/ddl2iterator.pl.create_cm_indices.log --database_type ${params.rdbms} \
        1>${params.tmp_dir}/ddl2iterator.pl.create_cm_indices.stdout \
        2>{{TMP_DIR}}/ddl2iterator.pl.create_cm_indices.stderr
    """
}

process List_tables {
    script:
    """
    ${params.bin_dir}/ddl2iterator --infile ${params.docs_dir}/ddls/${params.rdbms}/analyze_tables.${params.rdbms}.ddl --outfile ${params.tmp_dir}/analyze_table.list --logfile ${params.tmp_dir}/ddl2iterator.pl.analyze_table.log --database_type ${params.rdbms} \
        1>${params.tmp_dir}/ddl2iterator.pl.analyze_table.stdout \
        2>{{TMP_DIR}}/ddl2iterator.pl.analyze_table.stderr
    """
}

workflow {
    // Serial execution chain
    create_cache_directory()
    create_parse_temp_directory()
    Cache_primary_keys()
    list_bcp_files()
    trim_dups_files()
    create_tables_list()
    extract_checksums()
    mkdir_splitchecksums()
    split()
    create_sort_checksums_temp_directory()
    merge_sorted_split_checksum_files()
    assign_primary_keys()
    create_splitoffsets_directory()
    split()
    merge_sorted_split_checksum_files()
    replace_checksums()
    Drop_chado_mart_indices()
    Drop_indexes()
    list_bcp_files()
    Rebuild_indexes()
    Restore_chado_mart_indices()
    List_tables()
}
