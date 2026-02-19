#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Pipeline: RNA_Seq_Operon_Prediction
// Generated from Ergatis pipeline template by EELS
// Source: ergatis-install/templates/pipelines/RNA_Seq_Operon_Prediction/

// Component includes
// include { ... } from './bam2bigwig'
// include { ... } from './bowtie'
// include { ... } from './bowtie_build'
// include { ... } from './predict_operons'
// include { ... } from './samtools_file_convert'

workflow {
    bowtie_build_reference()  // bowtie_build.reference
    bowtie_alignment()  // bowtie.alignment
    samtools_file_convert_sorted_position()  // samtools_file_convert.sorted_position
    bam2bigwig_visualization()  // bam2bigwig.visualization
    predict_operons_predict()  // predict_operons.predict
}
