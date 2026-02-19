#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Pipeline: LGT_Seek_Pipeline_SRA
// Generated from Ergatis pipeline template by EELS
// Source: ergatis-install/templates/pipelines/LGT_Seek_Pipeline_SRA/

// Component includes
// include { ... } from './download_sra'
// include { ... } from './sra2fastq'

workflow {
    download_sra_default()  // download_sra.default
    sra2fastq_default()  // sra2fastq.default
}
