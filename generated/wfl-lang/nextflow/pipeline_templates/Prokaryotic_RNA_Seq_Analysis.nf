#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Pipeline: Prokaryotic_RNA_Seq_Analysis
// Generated from Ergatis pipeline template by EELS
// Source: ergatis-install/templates/pipelines/Prokaryotic_RNA_Seq_Analysis/

// Component includes
// include { ... } from './align_bowtie_stats'
// include { ... } from './align_tophat_stats'
// include { ... } from './bam2bigwig'
// include { ... } from './bowtie'
// include { ... } from './bowtie_build'
// include { ... } from './create_paired_list_file'
// include { ... } from './deseq'
// include { ... } from './edgeR'
// include { ... } from './expression_plots'
// include { ... } from './fastqc_stats'
// include { ... } from './fastx_quality_stats'
// include { ... } from './fastx_trimming'
// include { ... } from './filter_deseq'
// include { ... } from './htseq'
// include { ... } from './percent_mapped_stats'
// include { ... } from './rpkm_coverage_stats'
// include { ... } from './samtools_alignment_stats'
// include { ... } from './samtools_file_convert'
// include { ... } from './samtools_reference_index'
// include { ... } from './wrapper_align'

workflow {
    // No pipeline.layout - components listed from per-component layouts
    // align_bowtie_stats_bowtie_stats()
    // align_tophat_stats_tophat_stats()
    // bam2bigwig_visualization()
    // bowtie_alignment()
    // bowtie_build_reference()
    // create_paired_list_file_list()
    // deseq_differential_expression()
    // edgeR_edgeR_diff_expression()
    // expression_plots_deseq()
    // expression_plots_rpkm()
    // fastqc_stats_fastqc()
    // fastx_quality_stats_read1()
    // fastx_quality_stats_read2()
    // fastx_trimming_read1()
    // fastx_trimming_read2()
    // filter_deseq_filter_de()
    // htseq_exon_counts()
    // percent_mapped_stats_percent_mapped()
    // rpkm_coverage_stats_rpkm_cvg()
    // samtools_alignment_stats_alignment_stats()
    // samtools_file_convert_sam2sorted_bam()
    // samtools_file_convert_sorted_name()
    // samtools_file_convert_sorted_position()
    // samtools_reference_index_reference()
    // wrapper_align_wrap()
}
